//
//  FruitView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI


struct FruitView: View {
    let index: Int
    
    @EnvironmentObject var store: AppStore
    

    var body: some View {
        VStack {
            VStack {
                // TODO: - Add fruits stackview - 
                Text("Fruit")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct FruitView_Previews: PreviewProvider {
    static var previews: some View {
        FruitView(index: 0)
    }
}
