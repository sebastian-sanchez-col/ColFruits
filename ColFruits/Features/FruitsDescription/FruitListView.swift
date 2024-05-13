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
    private let numberOfColumns: Int = 2
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            Text("Fruits List")
                .font(.title)
                .padding()
            ForEach(rowIndices(), id: \.self) { rowIndex in
                HStack(spacing: 10) {
                    ForEach(0..<numberOfColumns, id: \.self) { columnIndex in
                        let index = rowIndex * numberOfColumns + columnIndex
                        if index < store.state.fruits.count {
                            FruitCardView(fruit: store.state.fruits[index])
                                .accessibilityIdentifier("Fruit-\(store.state.fruits[index].id)")
                        }
                    }
                }
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
        let fruitManager: FruitDataManager = .init()
        
        let previewStore: AppStore = {
            let store = AppStore.preview
            fruitManager.fetchFruitsFromFile(fileName: "MockFruits", completion: { result in
                switch result {
                case .success(let fruits):
                    print(fruits.count)
                    store.dispatch(.setFruits(fruits))
                case .failure(_):
                    break
                }
            })
            return store
        }()
        
        return FruitListView().environmentObject(previewStore)
    }
}
