//
//  NewsSceneDIContainer.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import Foundation
import UIKit

final class NewsSceneDIContainer: NewsFeedFlowCoordinatorDependencies {
    
    private let dataTransferService: DataTransferServiceInterface
    
    init(dataTransferService: DataTransferServiceInterface) {
        self.dataTransferService = dataTransferService
    }
    
    //MARK: Flows
    
    func makeNewsSceeneFlowCoordinator(navigationController: UINavigationController) -> NewsFeedFlowCoordinator {
        return NewsFeedFlowCoordinator(navigationController: navigationController, depenndencies: self)
    }
    
    //MARK: - ViewControllers
    
    func makeNewsFeedViewController() -> NewsFeedViewController {
        return NewsFeedViewController(with: makeNewsFeedViewModel())
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
       return NewsDataRepository(dataTransferService: dataTransferService)
    }
 
}
