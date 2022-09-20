//
//  AppFlowCoordinator.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import UIKit

final class AppFlowCoordinator {
    
    var navigationController: UINavigationController
    private let appDICOntainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDICOntainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDICOntainer = appDICOntainer
    }
    
    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let newsSceneDIContainer = appDICOntainer.makeNewsSceneDIContainer()
        let flow = newsSceneDIContainer.makeNewsSceeneFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
    
}
