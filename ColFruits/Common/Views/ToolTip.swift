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
    @Binding var bodyText: String
    @Binding var buttonTitle: String
    
    private let openAction: (() -> Void)?
    
    enum VoiceoverFocusArea: Hashable {
        case header
    }
    
    @State private var focusedVoiceoverArea: PassthroughSubject<VoiceoverFocusArea?, Never> = .init()
    
    public init (
        isPresented: Binding<Bool>,
        header: Binding<String>,
        bodyText: Binding<String>,
        buttonTitle: Binding<String>,
        openAction: (() -> Void)? = nil
    ) {
        _isPresented = isPresented
        _header = header
        _bodyText = bodyText
        _buttonTitle = buttonTitle
        self.openAction = openAction
    }
    
    public var body: some View {
        DynamicHeightBottomSheet(isPresented: $isPresented) {
            VStack(alignment: .leading) {
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
            }
            .padding([.leading, .top, .trailing], 30)
            .padding(.bottom, 15)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
        } openAction: {
            openAction?()
        }
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
                header: $header,
                bodyText: $bodyText,
                buttonTitle: $buttonTitle
            )
            .environment(\.topSafeAreaHeight, 44.0)
            .environment(\.bottomSafeAreaHeight, 34.0)
            .environment(\.screenViewHeight, UIScreen.main.bounds.height)
        }
    }
}
