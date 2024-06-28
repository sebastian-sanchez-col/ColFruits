//
//  AppStoreExtension.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 11/07/23.
//

import Foundation

extension AppStore {
    static var preview: AppStore {
        let store = AppStore(initial: AppState(), reducer: AppReducer)
        store.dispatch(.setFruits([
            FruitModel(id: "1", name: "StarFruit", description: "A fruit star", imageURL: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg0E_02JG6QtR2b9xqIuhofRhOarFrZG_IzUTAM5r1N7HAARC4aULO5c6yE72g2i5l1cRpZ-iiOmhfN6snviRnRcpAxeixwPZUkHGrbZM7sCPbN3DQS_jULgntSovA5552VYrgve2RPF2zLWXeV9nNecsJr84tAwjvq97XYTML0kHLXaZfEPOI5Fc1BkTZ4/s320/star-fruit.jpg"),
            FruitModel(id: "2", name: "Banana", description: "A yellow fruit.")
        ]))
        return store
    }
}
