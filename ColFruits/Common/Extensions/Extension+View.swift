//
//  Extension+View.swift
//  ColFruits
//
//  Created by Juan Sanchez on 13/05/24.
//

import SwiftUI

extension View {
    func customFruitCardModifier(useFrame: Bool, frameWidth: CGFloat, frameHeight: CGFloat) -> some View {
        modifier(CustomFruitCardModifier(useFrame: useFrame, frameWidth: frameWidth, frameHeight: frameHeight))
    }
}
