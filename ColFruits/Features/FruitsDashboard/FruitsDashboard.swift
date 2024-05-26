//
//  FruitsDashboard.swift
//  ColFruits
//
//  Created by Juan Sanchez on 26/05/24.
//

import SwiftUI

struct FruitsDashboard: View {
    @EnvironmentObject var store: AppStore
    
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

struct FruitsDashboard_Previews: PreviewProvider {
    static var previews: some View {
        let previewStore: AppStore = {
            let store = AppStore.preview
            return store
        }()
        
        HomeView().environmentObject(previewStore)
    }
}
