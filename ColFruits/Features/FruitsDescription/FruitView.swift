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
        frameWidth: CGFloat? = 140,
        frameHeight: CGFloat? = 128,
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
            
            Text(self.fruit.name)
                .font(.system(size: fontSize, weight: .regular))
                .frame(alignment: .leading)
        }
        .frame(width: frameWidth, height: frameHeight)
        .customFruitCardModifier(useFrame: shouldUseFrame)
        .animation(.linear)
        .onTapGesture {
            // TODO: - @ataches: store selected fruit -
        }
    }
    
    func getRandomFruitForComputer(idPlayerFruit: String, allFruits: [Fruit]) -> Fruit? {
        return allFruits.filter { $0.id != idPlayerFruit }.randomElement()
    }
}

struct CustomFruitCardModifier: ViewModifier {
    var useFrame: Bool
    
    func body(content: Content) -> some View {
        if useFrame {
            content
                .frame(width: 150, height: 139)
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

// TODO: - @ataches: relocate this view-
extension View {
    func customFruitCardModifier(useFrame: Bool) -> some View {
        modifier(CustomFruitCardModifier(useFrame: useFrame))
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
