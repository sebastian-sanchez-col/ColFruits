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
    @Binding var selectedFruitIndex: Int?
    
    var body: some View {
        VStack {
            if isPresented {
                if !store.state.fruits.isEmpty {
                    if let selectedFruitIndex: Int = $selectedFruitIndex.wrappedValue {
                        let fruit: FruitModel = store.state.fruits[selectedFruitIndex]
                        ToolTipBottomSheet(
                            isPresented: $isPresented,
                            imageURL: .constant(fruit.imageURL),
                            header: .constant(fruit.name),
                            bodyText: .constant(fruit.description),
                            buttonTitle: .constant("Close")
                        )
                    }
                }
            }
        }
    }
}

struct FruitBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresented: Bool = true
        @State var selectedFruitIndex: Int? = 1
        
        let mockFruits: [FruitModel] = [
            FruitModel(id: "1", name: "Apple", description: "A juicy fruit."),
            FruitModel(id: "2", name: "Banana", description: "A yellow fruit.")
        ]
        
        let previewStore: AppStore = {
            let store = AppStore.preview
            store.dispatch(.setFruits(mockFruits))
            return store
        }()
        
        return FruitBottomSheet(isPresented: $isPresented, selectedFruitIndex: $selectedFruitIndex)
            .environmentObject(previewStore)
    }
}
