//
//  FruitView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI


struct FruitView: View {
    let index: Int
    let videoNames: [String] = ["Intro", "Sightseeing"]
    let sectionNames: [String] = ["Introduction", "Countryside"]

    var body: some View {
        VStack {
            VStack {
                Text(sectionNames[index])
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            }
            Text("History")
            Text("In Colombia, where can you find that?")
            Text("Flavor")
        }
    }
}

struct FruitView_Previews: PreviewProvider {
    static var previews: some View {
        FruitView(index: 0)
    }
}
