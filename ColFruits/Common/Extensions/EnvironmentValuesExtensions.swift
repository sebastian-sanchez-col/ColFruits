//
//  EnvironmentValuesExtensions.swift
//  ColFruits
//
//  Created by Juan Sanchez on 28/05/24.
//

import Foundation
import SwiftUI

struct CustomStringKey: EnvironmentKey {
    static let defaultValue: String = ""
}

struct CustomCGFloatKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.0
}

struct CustomTopSafeAreaHeight: EnvironmentKey {
    static let defaultValue: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
}

struct CustomBottomSafeAreaHeight: EnvironmentKey {
    static let defaultValue: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
}

struct CustomScreenViewHeight: EnvironmentKey {
    static let defaultValue: CGFloat = UIScreen.main.bounds.height - (CustomTopSafeAreaHeight.defaultValue - CustomBottomSafeAreaHeight.defaultValue)
}

extension EnvironmentValues {
    var topSafeAreaHeight: CGFloat {
        get { self[CustomTopSafeAreaHeight.self] }
        set { self[CustomTopSafeAreaHeight.self] = newValue }
    }
    
    var bottomSafeAreaHeight: CGFloat {
        get { self[CustomBottomSafeAreaHeight.self] }
        set { self[CustomCGFloatKey.self] = newValue }
    }
    
    var screenViewHeight: CGFloat {
        get { self[CustomScreenViewHeight.self] }
        set { self[CustomCGFloatKey.self] = newValue }
    }
}
