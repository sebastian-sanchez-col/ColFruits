//
//  ColFruitsApp.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

@main
struct ColFruitsApp: App {    
    let store = AppStore(initial: AppState(), reducer: AppReducer)
    
    var body: some Scene {
        WindowGroup {
            IntroView()
                .environmentObject(store)
        }
    }
}
