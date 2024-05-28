//
//  Networking.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 11/07/23.
//

import Foundation
import Combine

class Networking {
    func makeRequest(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError { error -> Error in
                // Check if the error is an Error.
                if let error = error as? Error {
                    return error
                } else {
                    return NetworkingError.unknown
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
