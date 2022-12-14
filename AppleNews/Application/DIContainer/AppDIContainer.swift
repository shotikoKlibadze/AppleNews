//
//  AppDIContainer.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 20.09.22.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - Network
    
    lazy var newsSceneDataTransfer: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: nil) // URL(string: "someKindOfBaseURL")!
        let networkService = NetworkService(config: config)
        let dataTransferService = DataTransferService(networkService: networkService)
        return dataTransferService
    }()
    
    lazy var posterDataTransverService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: nil) // URL(string: "someKindOfBaseURL")!
        let networkService = NetworkService(config: config)
        let dataTransferService = DataTransferService(networkService: networkService)
        return dataTransferService
    }()
    
    // MARK: - DIContainer of Scenes -
    
    func makeNewsSceneDIContainer() -> NewsSceneDIContainer {
        let dependencies = NewsSceneDIContainer.Dependencies(apiDataTransferService: newsSceneDataTransfer,
                                                             imageDataTransferService: posterDataTransverService)
        return NewsSceneDIContainer(dependencies: dependencies)
    }
}
