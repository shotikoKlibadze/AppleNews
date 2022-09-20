//
//  NewsDataRepository.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 06.09.22.
//

import Foundation

final class NewsDataRepository: NewsRepositoryInterface {
    
    let dataTransferService: DataTransferServiceInterface
    
    init(dataTransferService: DataTransferServiceInterface) {
        self.dataTransferService = dataTransferService
    }
    
    func fetchNews(completion: @escaping ([NewsArticle]) -> Void) {
        
        dataTransferService.request(with: APIEndpoints.getNewsEndpoint()) { result in
            switch result {
                
            case .success(let data):
                completion(data.articles.map{$0.toDomain()})
            case .failure(_):
                print("oh oh oh")
            }
        }
    }
    
}
