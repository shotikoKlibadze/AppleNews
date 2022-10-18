//
//  RepositoryTask.swift
//  AppleNews
//
//  Created by Shotiko Klibadze on 17.10.22.
//

import Foundation

class RepositoryTask: Cancallable {
    var networkTask: NetworkCancallable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
