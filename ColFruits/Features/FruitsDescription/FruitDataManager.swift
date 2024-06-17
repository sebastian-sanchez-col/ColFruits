//
//  FruitList.swift
//  ColFruits
//
//  Created by Juan Sanchez on 7/05/24.
//

import SwiftUI
import Combine

class FruitDataManager: ObservableObject {
    func fetchFruitsFromFile(fileName: String? = "Fruits", completion: @escaping ((Result<[FruitModel], Error>) -> Void)) {
        if let fileURL: URL = Bundle.main.url(forResource: fileName, withExtension: ".json") {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder: JSONDecoder = JSONDecoder()
                let fruits: [FruitModel] = try decoder.decode([FruitModel].self, from: jsonData)
                completion(.success(fruits))
            } catch {
                completion(.failure(DataLoadingError.dataNotFound))
            }
        }
    }
}
