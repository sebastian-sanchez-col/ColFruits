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
    @State private var bottomSheetHeight: CGFloat = 0
    @GestureState private var translation: CGFloat = 0
    @Binding var isPresented: Bool
    @Binding var imageLoadedSize: CGFloat
    
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
        imageLoadedSize: Binding<CGFloat>,
        headingForLargeContent: String = "",
        @ViewBuilder content: () -> Content,
        openAction: (() -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self._imageLoadedSize = imageLoadedSize
        self.content = content()
        self.openAction = openAction
        self.headingForLargeContent = headingForLargeContent
    }
    
    public var body: some View {
        ZStack {
            if isPresented {
                backgroundTransparentView
                    .onTapGesture {
                        self.isPresented = false
                    }
            }
            VStack(spacing: 0) {
                if !contentHeightExceedsScreen {
                    content
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .padding(.all, 10)
                        .background(
                            GeometryReader { geometry in
                                Color.clear.preference(
                                    key: SizePreferenceKey.self,
                                    value: geometry.size
                                )
                            }
                        )
                        .onPreferenceChange(SizePreferenceKey.self) { preferences in
                            self.bottomSheetSize = CGSize(width: preferences.width, height: preferences.height)
                        }
                } else {
                    VStack(spacing: 0) {
                        HStack {
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
                                .cornerRadius(8)
                                .shadow(radius: 10)
                                .padding(.all, 10)
                                .background(
                                    GeometryReader { geometry in
                                        Color.clear.preference(
                                            key: SizePreferenceKey.self,
                                            value: geometry.size
                                        )
                                    }
                                )
                                .onPreferenceChange(SizePreferenceKey.self) { preferences in
                                    self.bottomSheetSize = CGSize(width: preferences.width, height: preferences.height)
                                }
                        }
                    }
                    
                }
            }
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - topSafeArea, alignment: .top)
            .offset(y: max(yOffset - imageLoadedSize + self.translation, 0))
            .animation(.linear(duration: 0.25))
            .onAppear {
                openAction?()
                if isPresented {
                    openHeight = bottomSheetSize.height
                }
            }
            .padding(.bottom, 15)
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

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        _ = nextValue()
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
                imageLoadedSize: .constant(0),
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
