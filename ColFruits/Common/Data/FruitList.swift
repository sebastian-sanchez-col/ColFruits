//
//  FruitList.swift
//  ColFruits
//
//  Created by Juan Sanchez on 7/05/24.
//

import SwiftUI
import Combine

class FruitList: ObservableObject {
    @EnvironmentObject var store: AppStore
    @Published var fruits: [Fruit] = []
    
    func fetchFruitsFromFile() {
        if let fileURL: URL = Bundle.main.url(forResource: "Fruits", withExtension: ".json") {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder: JSONDecoder = JSONDecoder()
                store.dispatch(.setFruits(try decoder.decode([Fruit].self, from: jsonData)))
            } catch {
                print("Error decoding JSON")
            }
        }
    }
}
