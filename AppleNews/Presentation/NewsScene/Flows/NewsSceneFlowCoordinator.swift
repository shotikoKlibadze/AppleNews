//
//  NewsSceneFlowCoordinator.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import Foundation
import UIKit

protocol NewsFeedFlowCoordinatorDependencies {
    func makeNewsFeedViewController() -> NewsFeedViewController
}

final class NewsFeedFlowCoordinator {
    
    private let dependencies: NewsFeedFlowCoordinatorDependencies
    private weak var navigationController: UINavigationController?
    private weak var newsFeedViewController: NewsFeedViewController?
    
    init(navigationController: UINavigationController,
         depenndencies: NewsFeedFlowCoordinatorDependencies) {
        self.dependencies = depenndencies
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = dependencies.makeNewsFeedViewController()
        navigationController?.pushViewController(vc, animated: false)
        newsFeedViewController = vc
    }
}
