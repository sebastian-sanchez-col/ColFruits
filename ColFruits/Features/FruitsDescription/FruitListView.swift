//
//  FruitView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct FruitListView: View {
    @ObservedObject var fruitList: FruitDataManager = .init()
    @EnvironmentObject var store: AppStore
    @State private var isPresented: Bool = false
    @State private var selectedFruitIndex: Int? = nil
    private let numberOfColumns: Int = 2
    
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
            if isPresented {
                FruitBottomSheet(isPresented: $isPresented, selectedFruitIndex: $selectedFruitIndex)
            }
        }
        .accessibilityIdentifier("FruitListVStackItems")
        .onAppear {
            fruitList.fetchFruitsFromFile { result in
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
        return FruitListView().environmentObject(AppStore.preview)
    }
}
