//
//  WelcomeView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        TabView {
            FruitsDashboard()
               .tabItem {
                   Image(systemName: "1.circle")
                   Text("Fruits")
               }
           Text("Curiosities")
               .tabItem {
                   Image(systemName: "2.circle")
                   Text("Curiosities")
               }
           Text("Configuration")
               .tabItem {
                   Image(systemName: "3.circle")
                   Text("Configuration")
               }
       }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        let previewStore: AppStore = {
            let store = AppStore.preview
            return store
        }()
        
        HomeView().environmentObject(previewStore)
    }
}
