//
//  SlideView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct SlideView: View {
    var images: [String]
    var titles: [String]
    var description: [String]
    var currentPage: Int
    @State private var cornerRadius: Double = 20.0
    @State private var shadowRadius: Double = 10.0
    @State private var maxWidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ScrollView(.horizontal) {
            Spacer()
                .frame(height: 10)
            Image(images[currentPage-1])
                .resizable()
                .frame(width: maxWidth * 0.95, height: maxWidth)
                .cornerRadius(cornerRadius)
                .shadow(color: .black, radius: shadowRadius)
                .onChange(of: currentPage) { newPage in
                    Text("Current page: \(newPage)")
                }
                .padding(.leading, maxWidth * 0.025)
            Spacer()
                .frame(height: 30)
            VStack {
                Text(titles[currentPage-1])
                    .bold()
                    .font(.title)
                Text(description[currentPage-1])
            }
            Spacer()
                .frame(height: 10)
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        SlideView(
            images: ["carousel-fruit_1"],
            titles: ["Title"],
            description: ["Description"],
            currentPage: 1
        )
    }
}
