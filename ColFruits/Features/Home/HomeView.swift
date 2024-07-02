//
//  WelcomeView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: AppStore
    @State private var fruitBottomSheet: FruitBottomSheet?
    @State private var isPresented: Bool = false
    @State private var selectedFruitIndex: Int? = nil
        
    var body: some View {
        ZStack {
            TabView {
                FruitsDashboard(isPresented: $isPresented, selectedFruitIndex: $selectedFruitIndex)
                   .tabItem {
                       Image(systemName: "1.circle")
                       Text("Fruits")
                   }
                   .onAppear() {
                       saveFruitBottomSheet()
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
           if isPresented {
             fruitBottomSheet
           }
        }
    }
    
    func saveFruitBottomSheet() {
        fruitBottomSheet = FruitBottomSheet(isPresented: $isPresented, selectedFruitIndex: $selectedFruitIndex)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppStore.preview)
    }
}
