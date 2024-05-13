//
//  FruitViewModel.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 11/07/23.
//

import Foundation

class Fruit: Codable, Identifiable  {
    var id: String
    var name: String
    var imageURL: String?
    
    init(id: String, name: String, imageURL: String? = nil) {
       self.id = id
       self.name = name
       self.imageURL = imageURL
   }
}
