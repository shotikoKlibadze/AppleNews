//
//  NewsRepositoryInterface.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 06.09.22.
//

import Foundation

protocol NewsRepositoryInterface {
    func fetchNews(completion: @escaping ([NewsArticle]) -> Void)
}
