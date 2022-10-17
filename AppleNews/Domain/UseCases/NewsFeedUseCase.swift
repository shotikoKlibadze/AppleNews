//
//  NewsFeedUseCase.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 05.09.22.
//

import Foundation

protocol NewsFeedUseCaseInterface {
    func fetchNews(completion: @escaping ([NewsArticle]) -> Void )
}

final class NewsFeedUseCase: NewsFeedUseCaseInterface {
    
    let newsDataRepository: NewsDataRepositoryInterface
    
    init(newsRepository: NewsDataRepositoryInterface) {
        self.newsDataRepository = newsRepository
    }
    
    func fetchNews(completion: @escaping ([NewsArticle]) -> Void) {
        newsDataRepository.fetchNews(completion: completion)
    }
    
}

