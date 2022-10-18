//
//  NewsSceneDIContainer.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import UIKit

final class NewsSceneDIContainer: NewsFeedFlowCoordinatorDependencies {
    
    
    
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: Flows
    
    func makeNewsSceeneFlowCoordinator(navigationController: UINavigationController) -> NewsFeedFlowCoordinator {
        return NewsFeedFlowCoordinator(navigationController: navigationController, depenndencies: self)
    }
    
    //MARK: - ViewControllers
    
    func makeNewsFeedViewController(actions: Actions) -> NewsFeedViewController {
        return NewsFeedViewController(viewModel: makeNewsFeedViewModel(actions: actions), imageDataTransferRepository: makePosterImageRepository())
    }
    
    func makeArtcildeDetailsViewController(with article: NewsArticle) -> NewsArticleDetailsViewController {
        let vc = NewsArticleDetailsViewController(article: article)
        return vc
    }
    
    
    
    
    //MARK: - ViewModels
    
    func makeNewsFeedViewModel(actions: Actions) -> NewsFeedViewModel {
        return NewsFeedViewModel(newsFeedUseCaseInterface: makeNewsFeedUseCase(), actions: actions)
    }
    
    // MARK: - UseCases
    
    func makeNewsFeedUseCase() -> NewsFeedUseCase {
        return NewsFeedUseCase(newsRepository: makeNewsDataRepository())
    }
    
    // MARK: - Repositories
    
    func makeNewsDataRepository() -> NewsDataRepository {
        return NewsDataRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    func makePosterImageRepository() -> PosterImageRepository {
        return PosterImageRepository(dataTransferService: dependencies.imageDataTransferService)
    }
 
}
