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

extension EnvironmentValues {
    var topSafeArea: CGFloat {
        get { self[CustomCGFloatKey.self] }
        set { self[CustomCGFloatKey.self] = newValue }
    }
    var bottomSafeArea: CGFloat {
        get { self[CustomCGFloatKey.self] }
        set { self[CustomCGFloatKey.self] = newValue }
    }
    var screenViewHeight: CGFloat {
        get { self[CustomCGFloatKey.self] }
        set { self[CustomCGFloatKey.self] = newValue }
    }
}
