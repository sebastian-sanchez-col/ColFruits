//
//  ToolTip.swift
//  ColFruits
//
//  Created by Juan Sanchez on 27/05/24.
//

import SwiftUI
import Combine

public struct ToolTipBottomSheet: View {
    @State var imageLoadedSize: CGFloat = 0
    @Binding var isPresented: Bool
    
    // MARK: - Private properties -
    private var imageMargin: CGFloat = 20
    private var imageHeight: CGFloat = 350
    private var toolTipBottomSheetViewModel: ToolTipBottomSheetViewModel
    
    enum VoiceoverFocusArea: Hashable {
        case header
    }
    
    @State private var focusedVoiceoverArea: PassthroughSubject<VoiceoverFocusArea?, Never> = .init()
    
    public init (
        isPresented: Binding<Bool>,
        toolTipBottomSheetViewModel: ToolTipBottomSheetViewModel
    ) {
        self._isPresented = isPresented
        self.toolTipBottomSheetViewModel = toolTipBottomSheetViewModel
    }
    
    public var body: some View {
        DynamicHeightBottomSheet(isPresented: $isPresented, imageLoadedSize: $imageLoadedSize) {
            VStack(alignment: .leading) {
                if let url: URL = toolTipBottomSheetViewModel.imageURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(7)
                            .onAppear() {
                                updateBottomSheetSize()
                            }
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 350, height: imageHeight)
                                       
                }
                HStack {
                    Text(toolTipBottomSheetViewModel.headerTitle)
                        .font(.title2)
                        .accessibilityElement()
                        .accessibilityLabel(toolTipBottomSheetViewModel.headerTitle)
                    if let informativeButtonAction: (() -> Void) = toolTipBottomSheetViewModel.informativeButtonAction {
                        TextButton(
                            text: toolTipBottomSheetViewModel.informativeButtonTitle ?? "Close",
                            image: Image("right-chevron"),
                            action: toolTipBottomSheetViewModel.informativeButtonAction,
                            alignment: .right
                        )
                    }
                }
                
                Spacer()
                    .frame(height: 12)
                Text(toolTipBottomSheetViewModel.bodyText)
                    .font(.title3)
                    .accessibilityElement()
                    .accessibilityLabel(toolTipBottomSheetViewModel.bodyText)
                Spacer()
                    .frame(height: 30)
                Button(toolTipBottomSheetViewModel.closeButtonTitle ?? "Close") {
                    isPresented = false
                }
                Spacer()
                    .frame(height: 30)
            }
            .padding([.leading, .trailing], 30)
            .padding(.bottom, 15)
            .background(Color.white)
            .shadow(radius: 10)
        } openAction: {
            toolTipBottomSheetViewModel.openAction?()
        }
        .accessibilityAddTraits(.isModal)
        .onChange(of: isPresented) { newValue in
            if newValue {
                focusedVoiceoverArea.send(.header)
            }
        }
        .padding(.bottom, 30)
    }
    
    func updateBottomSheetSize() {
        self.imageLoadedSize = imageHeight + imageMargin
    }
}

struct ToolTipBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State private var isPresented = true
        let toolTipBottomSheetViewModel: ToolTipBottomSheetViewModel = ToolTipBottomSheetViewModel(
            headerTitle: "Sample Header",
            bodyText: "This is a sample body text for the tooltip.",
            closeButtonTitle: "Close"
        )
        
        var body: some View {
            ToolTipBottomSheet(
                isPresented: $isPresented,
                toolTipBottomSheetViewModel: toolTipBottomSheetViewModel
            )
        }
    }
}
