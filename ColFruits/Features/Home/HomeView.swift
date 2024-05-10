//
//  WelcomeView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: AppStore
    @StateObject var fruitList = FruitList()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ScreenTitleView(title: "Welcome \nto colombian fruits", size: 36, font: .largeTitle)
                    .padding(.bottom, 17)
                    .accessibilityIdentifier("TitleTextView")
                ScreenTitleView(title: "Select one fruit", size: 24, font: .title2)
                    .padding(.bottom, 4)
                    .accessibilityIdentifier("SubTitleTextView")
                FruitListView()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
