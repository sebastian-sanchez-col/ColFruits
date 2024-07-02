//
//  FruitsDashboard.swift
//  ColFruits
//
//  Created by Juan Sanchez on 26/05/24.
//

import SwiftUI

struct FruitsDashboard: View {
    @EnvironmentObject var store: AppStore
    @Binding var isPresented: Bool
    @Binding var selectedFruitIndex: Int?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ScreenTitleView(title: "Welcome \nto colombian fruits", size: 36, font: .largeTitle)
                    .padding(.bottom, 17)
                    .accessibilityIdentifier("TitleTextView")
                ScreenTitleView(title: "Select one fruit", size: 24, font: .title2)
                    .padding(.bottom, 4)
                    .accessibilityIdentifier("SubTitleTextView")
                FruitListView(isPresented: $isPresented, selectedFruitIndex: $selectedFruitIndex)
            }
        }
    }
}

struct FruitsDashboard_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresented: Bool = false
        @State var selectedFruitIndex: Int? = 0
        
        HomeView().environmentObject(AppStore.preview)
    }
}
