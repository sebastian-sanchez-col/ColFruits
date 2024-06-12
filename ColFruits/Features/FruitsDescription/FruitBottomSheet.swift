//
//  FruitBottomSheet.swift
//  ColFruits
//
//  Created by Juan Sanchez on 6/06/24.
//

import SwiftUI

struct FruitBottomSheet: View {
    @EnvironmentObject var store: AppStore
    @Binding var isPresented: Bool
    @Binding var fruitIndex: Int
    
    var body: some View {
        VStack {
            if isPresented {
                if let fruitIndex: Int = store.state.fruits.indices.first(where: { $0 == fruitIndex }) {
                    ToolTipBottomSheet(
                        isPresented: $isPresented,
                        header: .constant(store.state.fruits[fruitIndex].name),
                        bodyText: .constant(store.state.fruits[fruitIndex].name),
                        buttonTitle: .constant(store.state.fruits[fruitIndex].name)
                    )
                }
            }
        }
    }
}

struct FruitBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresented: Bool = true
        
        let fruitManager: FruitDataManager = .init()
        
        let previewStore: AppStore = {
            let store = AppStore.preview
            fruitManager.fetchFruitsFromFile(fileName: "MockFruits", completion: { result in
                switch result {
                case .success(let fruits):
                    store.dispatch(.setFruits(fruits))
                case .failure(_):
                    break
                }
            })
            return store
        }()
        
        return FruitBottomSheet(
                isPresented: $isPresented,
                fruitIndex: .constant(0)
        ).environmentObject(previewStore)
    }
}
