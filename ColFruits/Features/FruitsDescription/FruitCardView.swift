//
//  FruitCardView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct FruitCardView: View {
    @EnvironmentObject var store: AppStore
    @Binding var index: Int
    @Binding var isPresented: Bool
    @Binding var selectedFruitIndex: Int?
    private var frameWidth: CGFloat
    private var frameHeight: CGFloat
    private var shouldUseFrame: Bool
    private var fontSize: CGFloat
    @State var fruit: FruitModel?
    
    init(
        index: Binding<Int>,
        isPresented: Binding<Bool>,
        selectedFruitIndex: Binding<Int?>,
        frameWidth: CGFloat = 180,
        frameHeight: CGFloat = 170,
        shouldUseFrame: Bool = true,
        fontSize: CGFloat = 16
    ) {
        self._index = index
        self._isPresented = isPresented
        self._selectedFruitIndex = selectedFruitIndex
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.shouldUseFrame = shouldUseFrame
        self.fontSize = fontSize
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if let fruit {
                if let imageURL: String = fruit.imageAddress,
                   let url: URL = URL(string: imageURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(7)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(7)
                }
                Button(fruit.name) {
                    self.isPresented = true
                    self.selectedFruitIndex = index
                }
                .font(.system(size: fontSize, weight: .regular))
                .foregroundColor(.black)
                .frame(alignment: .leading)
                .padding(5)
            }
        }
        .frame(width: frameWidth, height: frameHeight)
        .customFruitCardModifier(useFrame: shouldUseFrame, frameWidth: frameWidth, frameHeight: frameHeight)
        .animation(.linear)
        .onAppear() {
            loadFruit()
        }
    }
    
    func loadFruit() {
        fruit = store.state.fruits[index]
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
        @State var isPresented: Bool = false
        @State var selectedFruitIndex: Int? = 1
        @State var index: Int = 0
                
        return FruitCardView(index: $index, isPresented: $isPresented, selectedFruitIndex: $selectedFruitIndex)
                .environmentObject(AppStore.preview)
    }
}
