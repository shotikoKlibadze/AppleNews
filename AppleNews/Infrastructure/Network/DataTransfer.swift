//
//  DataTransfer.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 05.09.22.
//

import Foundation
import UIKit

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}


protocol DataTransferServiceInterface {
    typealias CompletionHandler<T> = (Result<T,DataTransferError>) -> Void
    
    @discardableResult
    func request<T: Decodable, E: ResponseRequastable>(with endpoint: E,
                                                       completion: @escaping CompletionHandler<T>) -> NetworkCancallable? where E.Response == T
    func request<E: ResponseRequastable>(with endpoint: E,
                                         completion: @escaping CompletionHandler<Void>) -> NetworkCancallable? where E.Response == Void
}

protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

protocol DataTransferErrorLogger {
    func log(error: Error)
}

final class DataTransferService: DataTransferServiceInterface {
    
    private let networkService: NetworkServiceInterface
    private let errorResolver: DataTransferErrorResolver
    private let errorLogger: DataTransferErrorLogger
    
    public init(networkService: NetworkServiceInterface,
                errorResolver: DataTransferErrorResolver = DefaultDataTransferErrorResolver(),
                errorLogger: DataTransferErrorLogger = DefaultDataTransferErrorLogger()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
    
    func request<T, E>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> NetworkCancallable? where T : Decodable, T == E.Response, E : ResponseRequastable {
        
        return self.networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                DispatchQueue.main.async { return completion(result) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
        
    }
    
    func request<E>(with endpoint: E, completion: @escaping CompletionHandler<Void>) -> NetworkCancallable? where E : ResponseRequastable, E.Response == Void {
        
        return self.networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success:
                DispatchQueue.main.async { return completion(.success(())) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
        
    }
    
    // MARK: - Private
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
    
    
}

// MARK: - Logger
final class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
    public init() { }
    
    public func log(error: Error) {
        printIfDebug("-------------")
        printIfDebug("\(error)")
    }
}

// MARK: - Error Resolver
class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    init() { }
    func resolve(error: NetworkError) -> Error {
        return error
    }
}


//MARK: - ResponseDecoders

class JSONResponseDecoder: ResponseDecoder {
    
    private let jsonDecoder = JSONDecoder()
    
    init(){}
    
    func decode<T>(_ data: Data) throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }

}


