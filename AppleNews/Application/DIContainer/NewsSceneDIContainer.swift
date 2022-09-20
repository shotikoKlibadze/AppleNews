//
//  NewsSceneDIContainer.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import Foundation

final class NewsSceneDIContainer {
    
    private let dataTransferService: DataTransferServiceInterface
    
    init(dataTransferService: DataTransferServiceInterface) {
        self.dataTransferService = dataTransferService
    }
    
    // MARK: - Use Cases
    
    func makeNewsFeedUseCase() -> NewsFeedUseCase {
        return NewsFeedUseCase(newsRepository: makeNewsDataRepository())
    }
    
    // MARK: - Repositories
    
    func makeNewsDataRepository() -> NewsDataRepository {
       return NewsDataRepository(dataTransferService: dataTransferService)
    }
 
}
