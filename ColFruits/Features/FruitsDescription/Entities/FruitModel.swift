//
//  FruitModel.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 11/07/23.
//

import Foundation

class FruitModel: Codable, Identifiable  {
    var id: String
    var name: String
    var description: String
    var imageAddress: String?
    
    init(id: String, name: String, description: String, imageAddress: String? = nil) {
       self.id = id
       self.name = name
       self.description = description
       self.imageAddress = imageAddress
   }
}
