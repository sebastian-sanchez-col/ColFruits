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
    @State var imageURL: URL?
    
    var body: some View {
        VStack {
            if isPresented {
                if !store.state.fruits.isEmpty {
                    if let selectedFruitIndex: Int = $selectedFruitIndex.wrappedValue {
                        let fruit: FruitModel = store.state.fruits[selectedFruitIndex]
                        let viewModel: ToolTipBottomSheetViewModel = .init(
                            imageURL: imageURL, 
                            headerTitle: fruit.name,
                            bodyText: fruit.description
                        )
                        ToolTipBottomSheet(isPresented: $isPresented, toolTipBottomSheetViewModel: viewModel)
                        .onAppear() {
                            loadImage(imageAddress: fruit.imageAddress)
                        }
                    }
                }
            }
        }
    }
    
    func loadImage(imageAddress: String?) {
        guard let imageAddress else { return }
        imageURL = URL(string: imageAddress)
    }
}

struct FruitBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresented: Bool = true
        @State var selectedFruitIndex: Int? = 0
        
        return FruitBottomSheet(isPresented: $isPresented, selectedFruitIndex: $selectedFruitIndex)
            .environmentObject(AppStore.preview)
    }
}
	
