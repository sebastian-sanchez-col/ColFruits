//
//  FruitView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct FruitListView: View {
    @EnvironmentObject var store: AppStore
    @Binding var isPresented: Bool
    @Binding var selectedFruitIndex: Int?
    private let numberOfColumns: Int = 2
    var fruitListManager: FruitDataManager = FruitDataManager()
    
    var body: some View {
        ZStack {
            VStack (alignment: .center, spacing: 10) {
                Text("Fruits List")
                    .font(.title)
                    .padding()
                ForEach(rowIndices(), id: \.self) { rowIndex in
                    HStack {
                        ForEach(0..<numberOfColumns, id: \.self) { columnIndex in
                            let index = rowIndex * numberOfColumns + columnIndex
                            if index < store.state.fruits.count {
                                FruitCardView(
                                    index: .constant(index),
                                    isPresented: $isPresented,
                                    selectedFruitIndex: $selectedFruitIndex
                                )
                                .accessibilityIdentifier("Fruit-\(store.state.fruits[index].id)")
                            }
                        }
                    }
                } 
            }
        }
        .accessibilityIdentifier("FruitListVStackItems")
        .onAppear {
            fruitListManager.fetchFruitsFromFile { result in
                switch result {
                case .success(let fruits):
                    print(fruits.count)
                    store.dispatch(.setFruits(fruits))
                case .failure(let error):
                    // TODO: - @ataches, Create error view -
                    break
                }
            }
        }
    }
    
    func rowIndices() -> Range<Int> {
        return 0..<store.state.fruits.count / numberOfColumns + (store.state.fruits.count % numberOfColumns == 0 ? 0 : 1)
    }
}

struct FruitView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresented: Bool = true
        @State var selectedFruitIndex: Int? = 0
    
        return FruitListView(isPresented: $isPresented, selectedFruitIndex: $selectedFruitIndex).environmentObject(AppStore.preview)
    }
}
