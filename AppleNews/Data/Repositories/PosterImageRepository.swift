//
//  PosterImageRepository.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 23.09.22.
//

import Foundation

final class PosterImageRepository: PosterImageRepositoryInterface {
   
    let dataTransferService: DataTransferServiceInterface
    
    init(dataTransferService: DataTransferServiceInterface) {
        self.dataTransferService = dataTransferService
    }
    
    func fetchPoster(imageURLString: String, completion: @escaping (Data) -> Void) -> Cancallable? {
        let endpoint = APIEndpoints.getMoviePosterEndpoint(URLString: imageURLString)
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success( let data):
                completion(data)
            case .failure(_):
                print("error fetching poster")
            }
        }
        return task
    }
}
