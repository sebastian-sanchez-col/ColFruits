//
//  FruitView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI


struct FruitView: View {
    @StateObject var fruitList = FruitList()
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack {
            Text("List of Fruits")
                .font(.title)
                .padding()
            
            ForEach(Array(store.state.fruits.enumerated()), id: \.element.id) { index, fruit in
                Text(fruit.name)
                    .accessibilityIdentifier("Fruit-\(fruit.id)")

            }
            .accessibilityIdentifier("FruitViewHStackItems")
            
        }.onAppear {
            fruitList.fetchFruitsFromFile { result in
                switch result {
                case .success(let fruits):
                    store.dispatch(.setFruits(fruits))
                case .failure(let error):
                    // TODO: - @ataches, Create error view -
                    break
                }
            }
        }
    }
}

struct FruitView_Previews: PreviewProvider {
    static var previews: some View {
        FruitView()
    }
}
