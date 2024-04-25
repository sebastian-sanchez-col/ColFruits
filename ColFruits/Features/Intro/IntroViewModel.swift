//
//  IntroViewModel.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 13/07/23.
//

import Foundation

class IntroViewModel: ObservableObject {
    @Published var images = ["carousel-fruit_1", "carousel-fruit_2", "carousel-fruit_3"]
    @Published var titles = ["Fruits made easy", "Healt for everyone", "Learn more about fruits"]
    @Published var descriptions = ["Are they a secret for you?", "Explore about them", "Wich are the benefits for you?"]
}
