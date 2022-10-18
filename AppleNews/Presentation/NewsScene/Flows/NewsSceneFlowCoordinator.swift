//
//  NewsSceneFlowCoordinator.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import UIKit

protocol NewsFeedFlowCoordinatorDependencies {
    func makeNewsFeedViewController(actions: Actions) -> NewsFeedViewController
    func makeArtcildeDetailsViewController(with article: NewsArticle) -> NewsArticleDetailsViewController
}

final class NewsFeedFlowCoordinator {
    
    private let dependencies: NewsFeedFlowCoordinatorDependencies
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController,
         depenndencies: NewsFeedFlowCoordinatorDependencies) {
        self.dependencies = depenndencies
        self.navigationController = navigationController
    }
    
    func start() {
        let actions = Actions(showDetailsForArticle: showDetailsForArticle(article:))
        let vc = dependencies.makeNewsFeedViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func showDetailsForArticle(article: NewsArticle) {
        let vc = dependencies.makeArtcildeDetailsViewController(with: article)
        navigationController?.pushViewController(vc, animated: true)
    }
}
