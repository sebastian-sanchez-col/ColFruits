//
//  FruitView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct FruitCardView: View {
    @EnvironmentObject var store: AppStore
    @Binding var fruit: Fruit
    @Binding var isPresented: Bool
    private var frameWidth: CGFloat?
    private var frameHeight: CGFloat?
    private var shouldUseFrame: Bool
    private var fontSize: CGFloat
    
    init(
        fruit: Binding<Fruit>,
        isPresented: Binding<Bool>,
        frameWidth: CGFloat? = 180,
        frameHeight: CGFloat? = 170,
        shouldUseFrame: Bool = true,
        fontSize: CGFloat = 16
    ) {
        self._fruit = fruit
        self._isPresented = isPresented
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.shouldUseFrame = shouldUseFrame
        self.fontSize = fontSize
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: $fruit.imageURL.wrappedValue ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(7)
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 7)
                        
            Button(fruit.name) {
                self.isPresented = true
            }
            .font(.system(size: fontSize, weight: .regular))
            .foregroundColor(.black)
            .frame(alignment: .leading)
            .padding(30)
        }
        .frame(width: frameWidth, height: frameHeight)
        .customFruitCardModifier(useFrame: shouldUseFrame, frameWidth: frameWidth ?? 150, frameHeight: frameHeight ?? 139)
        .animation(.linear)
        .onTapGesture {
            // TODO: - @ataches: store selected fruit -
        }
    }
}

struct CustomFruitCardModifier: ViewModifier {
    var useFrame: Bool
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    
    func body(content: Content) -> some View {
        if useFrame {
            content
                .frame(width: frameWidth, height: frameHeight)
                .background(Color.white)
                .cornerRadius(7)
                .shadow(color: .black.opacity(0.25), radius: 7, x: -2, y: 3)
                .padding([.horizontal, .bottom], 7)
                .padding(.top, 6)
        } else {
            content
        }
    }
}

struct FruitCardView_Previews: PreviewProvider {
    static var previews: some View {
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
        
        let fruit: Fruit = previewStore.state.fruits.first ?? Fruit(id: "fruit-1", name: "test")
        
        return FruitCardView(fruit: .constant(fruit), isPresented: .constant(false))
                .environmentObject(previewStore)
    }
}
