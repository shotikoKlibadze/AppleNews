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
    
    let newsRepository: NewsRepositoryInterface
    
    init(newsRepository: NewsRepositoryInterface) {
        self.newsRepository = newsRepository
    }
    
    
    func fetchNews(completion: @escaping ([NewsArticle]) -> Void) {
        newsRepository.fetchNews(completion: completion)
    }
    
    
}

