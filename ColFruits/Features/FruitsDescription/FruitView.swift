//
//  FruitView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct FruitCardView: View {
    @EnvironmentObject var store: AppStore
    private var fruit: Fruit
    private var frameWidth: CGFloat?
    private var frameHeight: CGFloat?
    private var shouldUseFrame: Bool
    private var fontSize: CGFloat
    private var imageURL: String = ""
    
    init(
        fruit: Fruit,
        frameWidth: CGFloat? = 180,
        frameHeight: CGFloat? = 170,
        shouldUseFrame: Bool = true,
        fontSize: CGFloat = 16
    ) {
        self.fruit = fruit
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.shouldUseFrame = shouldUseFrame
        self.fontSize = fontSize
        if let imageURL: String = fruit.imageURL {
            self.imageURL = imageURL
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: self.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(7)
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 7)
            
            Text(fruit.name)
                .font(.system(size: fontSize, weight: .regular))
                .foregroundColor(.black)
                .frame(alignment: .leading)
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

#if !TESTING
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
        
        return FruitCardView(fruit: previewStore.state.fruits.first ?? Fruit(id: "fruit-1", name: "test"))
                .environmentObject(previewStore)
    }
}
#endif
