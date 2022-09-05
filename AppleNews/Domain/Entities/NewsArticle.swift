//
//  NewsArticle.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 01.09.22.
//

import Foundation

struct NewsArticle {
    let source: ArticleSource
    let author: String
    let title: String
    let description: String
    let webURL: String
    let imageURL: String
    let publishedAt: Date?
}

struct ArticleSource {
    let id, name: String
}
