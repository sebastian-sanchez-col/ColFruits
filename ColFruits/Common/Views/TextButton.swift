//
//  TextButton.swift
//  ColFruits
//
//  Created by Juan Sanchez on 4/07/24.
//

import SwiftUI

public enum TextButtonHorizontalAligment {
    case left
    case right
}

public struct TextButton: View {
    private var text: String
    private var image: Image?
    private var alignment: TextButtonHorizontalAligment
    private var action: (()->Void)?
    
    public init(
        text: String,
        image: Image? = nil,
        action: (()->Void)? = nil,
        alignment: TextButtonHorizontalAligment = .left
    ) {
        self.text = text
        self.image = image
        self.alignment = alignment
        self.action = action
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 6) {
            switch alignment {
            case .left:
                image
                Button(text) {
                    action?()
                }
            case .right:
                Button(text) {
                    action?()
                }
                image
            }
        }
    }
}
