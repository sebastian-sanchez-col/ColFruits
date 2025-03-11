//
//  ToolTipBottomSheetViewModel.swift
//  ColFruits
//
//  Created by Juan Sanchez on 5/07/24.
//

import Foundation

public struct ToolTipBottomSheetViewModel {
    
    // MARK: - Internal properties -
    var headerTitle: String
    var imageURL: URL?
    var bodyText: String
    var closeButtonTitle: String?
    var informativeButtonTitle: String?
    var informativeButtonAction: (() -> Void)?
    let openAction: (() -> Void)?
    
    public init (
        imageURL: URL? = nil,
        headerTitle: String,
        bodyText: String,
        closeButtonTitle: String? = "Close",
        informativeButtonTitle: String? = nil,
        informativeButtonAction: (() -> Void)? = nil,
        openAction: (() -> Void)? = nil
    ) {
        self.imageURL = imageURL
        self.headerTitle = headerTitle
        self.bodyText = bodyText
        self.closeButtonTitle = closeButtonTitle
        self.informativeButtonTitle = informativeButtonTitle
        self.informativeButtonAction = informativeButtonAction
        self.openAction = openAction
    }
}
