//
//  ToolTip.swift
//  ColFruits
//
//  Created by Juan Sanchez on 27/05/24.
//

import SwiftUI
import Combine

public struct ToolTipBottomSheet: View {
    @Binding var isPresented: Bool
    @Binding var header: String
    @Binding var imageURL: URL?
    @Binding var bodyText: String
    @Binding var buttonTitle: String
    
    private let openAction: (() -> Void)?
    
    enum VoiceoverFocusArea: Hashable {
        case header
    }
    
    @State private var focusedVoiceoverArea: PassthroughSubject<VoiceoverFocusArea?, Never> = .init()
    
    public init (
        isPresented: Binding<Bool>,
        imageURL: Binding<URL?>,
        header: Binding<String>,
        bodyText: Binding<String>,
        buttonTitle: Binding<String>,
        openAction: (() -> Void)? = nil
    ) {
        _isPresented = isPresented
        _imageURL = imageURL
        _header = header
        _bodyText = bodyText
        _buttonTitle = buttonTitle
        self.openAction = openAction
    }
    
    public var body: some View {
        DynamicHeightBottomSheet(isPresented: $isPresented) {
            VStack(alignment: .leading) {
                if let url: URL = imageURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(7)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 350, height: 350)
                }
                Text(header)
                    .font(.title2)
                    .accessibilityElement()
                    .accessibilityLabel(header)
                Spacer()
                    .frame(height: 12)
                Text(bodyText)
                    .font(.title3)
                    .accessibilityElement()
                    .accessibilityLabel(bodyText)
                Spacer()
                    .frame(height: 30)
                Button(buttonTitle) {
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
            openAction?()
        }
        .accessibilityAddTraits(.isModal)
        .onChange(of: isPresented) { newValue in
            if newValue {
                focusedVoiceoverArea.send(.header)
            }
        }
        .padding(.bottom, 30)
    }
}


struct ToolTipBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State private var isPresented = true
        @State private var header = "Sample Header"
        @State private var bodyText = "This is a sample body text for the tooltip."
        @State private var buttonTitle = "Close"
        
        var body: some View {
            ToolTipBottomSheet(
                isPresented: $isPresented,
                imageURL: .constant(nil),
                header: $header,
                bodyText: $bodyText,
                buttonTitle: $buttonTitle
            )
        }
    }
}
