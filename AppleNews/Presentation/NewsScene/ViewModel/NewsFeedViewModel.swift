//
//  NewsFeedViewModel.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 05.09.22.
//

import Foundation

struct Actions {
    /// Note: if you would need to edit Article inside Details screen and update this Article List screen with updated article then you would need this closure:
    /// showDetailsForArticle: (NewsArticle, @escaping (_ updated: NewsArticle) -> Void) -> Void
    let showDetailsForArticle: (NewsArticle) -> Void
}

protocol NewsFeedViewModelInput {
    var items: Observable<[NewsFeedItemViewModel]> { get }
}

protocol NewsFeedViewModelOutput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
}

protocol NewsFeedViewModelProtocol: NewsFeedViewModelInput, NewsFeedViewModelOutput {}

final class NewsFeedViewModel : NewsFeedViewModelProtocol {
    
    
    var items: Observable<[NewsFeedItemViewModel]> = Observable([])
    private var articles = [NewsArticle]()
    
    private let newsFeedUseCaseInterface: NewsFeedUseCaseInterface
    private var actions: Actions
    
    init(newsFeedUseCaseInterface: NewsFeedUseCaseInterface, actions: Actions) {
        self.newsFeedUseCaseInterface = newsFeedUseCaseInterface
        self.actions = actions
    }
    
    func viewDidLoad() {
        newsFeedUseCaseInterface.fetchNews { [weak self] articles in
            self?.appendItems(newsArticles: articles)
            //articles.append(articles)
            self?.articles = articles
        }
    }
    
    private func appendItems(newsArticles: [NewsArticle]) {
        items.value = newsArticles.map(NewsFeedItemViewModel.init)
    }
    
    func didSelectItem(at index: Int) {
        actions.showDetailsForArticle(articles[index])
    }

}
