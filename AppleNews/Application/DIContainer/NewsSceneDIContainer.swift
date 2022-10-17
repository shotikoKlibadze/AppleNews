//
//  NewsSceneDIContainer.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import Foundation
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
    
    func makeNewsFeedViewController() -> NewsFeedViewController {
        return NewsFeedViewController(viewModel: makeNewsFeedViewModel(), imageDataTransferRepository: makePosterImageRepository())
    }
    
    //MARK: - ViewModels
    
    func makeNewsFeedViewModel() -> NewsFeedViewModel {
        return NewsFeedViewModel(newsFeedUseCaseInterface: makeNewsFeedUseCase())
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
