//
//  NewsArticleResponse+Mapping.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 01.09.22.
//

import Foundation

struct NewsArticleResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleData]
}

struct Source: Codable {
    let id: String?
    let name: String?
}

struct ArticleData: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

extension ArticleData {
    
    func toDomain() -> NewsArticle {
        return .init(source: ArticleSource(id: source?.id , name: source?.name),
                     author: author,
                     title: title,
                     description: description,
                     webURL: url,
                     imageURL: urlToImage,
                     publishedAt: nil)
    }
}

