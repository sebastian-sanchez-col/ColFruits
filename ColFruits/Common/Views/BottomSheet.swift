//
//  BottomSheet.swift
//  ColFruits
//
//  Created by Juan Sanchez on 27/05/24.
//

import SwiftUI

public struct DynamicHeightBottomSheet<Content: View>: View {
    
    @Environment(\.topSafeAreaHeight) var topSafeArea
    @Environment(\.bottomSafeAreaHeight) var bottomSafeArea
    @Environment(\.screenViewHeight) var screenViewHeight
    
    @State var openHeight: CGFloat = 0
    @State private var bottomSheetSize: CGSize = .zero
    
    @GestureState private var translation: CGFloat = 0
    @Binding var isPresented: Bool
    
    let content: Content
    let headingForLargeContent: String
    let openAction: (() -> Void)?
    
    private var contentHeightOffset: CGFloat {
        let compensateHeightForSmallSizePhone: CGFloat = bottomSafeArea == 0.0 ? 30 : 0
        return screenViewHeight - openHeight - compensateHeightForSmallSizePhone
    }
    
    private var contentHeightExceedsScreen: Bool {
        return contentHeightOffset < topSafeArea
    }
    
    private var yOffset: CGFloat {
        return isPresented ? (contentHeightExceedsScreen ? topSafeArea : contentHeightOffset) : UIScreen.main.bounds.height
    }
    
    public init(
        isPresented: Binding<Bool>,
        headingForLargeContent: String = "",
        @ViewBuilder content: () -> Content,
        openAction: (() -> Void)? = nil
    ) {
        self._isPresented = isPresented
        let content = content()
        self.content = content
        self.openAction = openAction
        self.headingForLargeContent = headingForLargeContent
    }
    
    public var body: some View {
        ZStack {
            if isPresented {
                backgroundTransparentView
            }
            VStack(spacing: 0) {
                if !contentHeightExceedsScreen {
                    content
                        .background(Color.white) 
                        .cornerRadius(16)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                        .opacity(isPresented ? 1 : 0)
                } else {
                    HStack(alignment: .center) {
                        Spacer()
                        Text(headingForLargeContent)
                            .font(.title2)
                        Spacer()
                        Image(systemName: "1.circle")
                    }
                    .padding(20)
                    Divider()
                    ScrollView {
                        content
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 10)
                            .padding(.horizontal)
                            .opacity(isPresented ? 1 : 0)
                    }
                }
            }
            .onReceive([$bottomSheetSize].publisher.first()) { size in
                if isPresented {
                    openHeight = bottomSheetSize.height
                }
            }
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - topSafeArea, alignment: .top)
            .offset(y: max(yOffset + self.translation, 0))
            .onAppear {
                openAction?()
            }
        }
        .animation(.linear(duration: 0.25))
        .onTapGesture {
            self.isPresented.toggle()
        }
        .gesture(dragGesture)
    }
    
    @ViewBuilder
    private var backgroundTransparentView: some View {
        Rectangle()
            .fill(Color.black.opacity(0.5))
            .edgesIgnoringSafeArea(.all)
    }
    
    // MARK: - Drag gesture -
    private var dragGesture: some Gesture {
        DragGesture().updating(self.$translation) { value, state, _ in
            state = value.translation.height
        }
        .onEnded { value in
            if value.translation.height > 50 {
                self.isPresented = false
            }
        }
    }
}


struct DynamicHeightBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State private var isPresented = true
        
        var body: some View {
            DynamicHeightBottomSheet(
                isPresented: $isPresented,
                headingForLargeContent: "Large Content Heading"
            ) {
                VStack {
                    Text("Hello, World!")
                    Text("This is a sample content.")
                }
            }
        }
    }
}
