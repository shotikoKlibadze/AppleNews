//
//  NewsFeedViewModel.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 05.09.22.
//

import Foundation

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
    
    private let newsFeedUseCaseInterface: NewsFeedUseCaseInterface
    
    init(newsFeedUseCaseInterface: NewsFeedUseCaseInterface) {
        self.newsFeedUseCaseInterface = newsFeedUseCaseInterface
    }
    
    func viewDidLoad() {
        newsFeedUseCaseInterface.fetchNews { [weak self] articles in
            self?.appendItems(newsArticles: articles)
        }
    }
    
    private func appendItems(newsArticles: [NewsArticle]) {
        items.value = newsArticles.map(NewsFeedItemViewModel.init)
    }
    
    func didSelectItem(at index: Int) {
        
    }

}
