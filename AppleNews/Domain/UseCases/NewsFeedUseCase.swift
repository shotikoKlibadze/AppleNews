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

