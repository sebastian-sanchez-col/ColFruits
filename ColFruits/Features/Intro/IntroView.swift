//
//  IntroView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 12/07/23.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var store: AppStore
    @State var isLastPage = false
    @State private var currentPage: Int = 1
    
    private var viewModel: IntroViewModel = IntroViewModel()
    
    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 50)
            SlideView(
                images: viewModel.images,
                titles: viewModel.titles,
                description: viewModel.descriptions,
                currentPage: currentPage
            )
        }
        .overlay(
            HStack(spacing: 150) {
                Button(action: {
                    if currentPage > 1 {
                        currentPage -= 1
                    } else {
                        isLastPage = true
                    }
                }) {
                    if currentPage > 1 {
                        Text("Previous")
                    } else {
                        Text("Skip")
                    }
                }
                .fullScreenCover(isPresented: $isLastPage) {
                    HomeView().environmentObject(store)
                }
                Button(action: {
                    if currentPage >= 3 {
                        isLastPage = true
                    } else {
                        currentPage += 1
                    }
                }) {
                    Text("Next")
                }
            }
            .padding(.bottom, 20),
            alignment: .bottom
        )
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView().environmentObject(AppStore.preview)
    }
}
