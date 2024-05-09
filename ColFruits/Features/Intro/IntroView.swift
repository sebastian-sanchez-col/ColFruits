//
//  IntroView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 12/07/23.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var store: AppStore
    @ObservedObject var viewModel: IntroViewModel = IntroViewModel()
    @State var isPresentingSecondView = false
    @State private var currentPage: Int = 1

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
                        isPresentingSecondView = true
                    }
                }) {
                    if currentPage > 1 {
                        Text("Previous")
                    } else {
                        Text("Skip")
                    }
                }
                .fullScreenCover(isPresented: $isPresentingSecondView) {
                    HomeView()
                }
                Button(action: {
                    if currentPage >= 3 {
                        isPresentingSecondView = true
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
        IntroView()
    }
}
