//
//  PosterImageRepositoryInterface.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 23.09.22.
//

import Foundation

protocol PosterImageRepositoryInterface {
    func fetchPoster(imageURLString: String, completion: @escaping (Data) -> Void) -> Cancallable?
}
