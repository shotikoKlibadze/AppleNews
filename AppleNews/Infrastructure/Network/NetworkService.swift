//
//  NetworkService.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 01.09.22.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case error
    case notConnceted
    case canceled
    case generic(Error)
    case urlGeneration
}

protocol NetworkCancallable {
    func cancel()
}

extension URLSessionTask: NetworkCancallable { }

protocol NetworkService {
    
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endPoint: Requastable, completion: @escaping CompletionHandler) -> NetworkCancallable
}


