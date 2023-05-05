//
//  ExerciseView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI


struct ExerciseView: View {
    let index: Int
    let videoNames: [String] = ["Intro", "Sightseeing"]
    let sectionNames: [String] = ["Introduction", "Countryside"]

    var body: some View {
        Text(sectionNames[index])
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(index: 0)
    }
}
