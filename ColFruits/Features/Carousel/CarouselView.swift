//
//  PrincipalCarousel.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct CarouselView: View {
    @ObservedObject var viewModel = CarouselViewModel()
    @State private var currentPage = 0
    @State private var cornerRadius = 10.0
    @State private var shadowRadius = 20.0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<viewModel.images.count) { index in
                    Image(viewModel.images[index])
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(cornerRadius)
                        .shadow(color: .black, radius: shadowRadius)
                        .offset(x: CGFloat((-currentPage * 200)))
                        .onTapGesture {
                            currentPage = index
                        }
                        .onChange(of: currentPage) { newPage in
                            Text("Current page: \(newPage)")
                        }
                }
            }
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
