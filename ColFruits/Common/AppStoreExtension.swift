//
//  AppStoreExtension.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 11/07/23.
//

import Foundation

extension AppStore {
  static var preview: AppStore {
    AppStore(
      initial: AppState(),
      reducer: AppReducer
    )
  }
}
