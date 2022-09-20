//
//  NewsFeedItemViewModel.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 05.09.22.
//

import Foundation

struct NewsFeedItemViewModel {
    let title: String?
    let limitedOverview: String?
    let source: String?
    let posterImage: String?
    
    init(article: NewsArticle) {
        self.title = article.title
        self.posterImage = article.imageURL
        self.source = article.source?.name
        self.limitedOverview = article.description
    }
}
