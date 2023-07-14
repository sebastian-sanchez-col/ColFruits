//
//  FruitViewModel.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 11/07/23.
//

import Foundation

class FruitViewModel: ObservableObject {
    @Published var videoNames: [String] = ["Intro", "Sightseeing"]
    @Published var sectionNames: [String] = ["Introduction", "Countryside"]
}
