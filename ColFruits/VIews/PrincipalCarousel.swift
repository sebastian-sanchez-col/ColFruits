//
//  PrincipalCarousel.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct PrincipalCarousel: View {
    var body: some View {
        TabView {
            Text("Welcome \nto colombian fruits")
                .multilineTextAlignment(.center)
                .tabItem { Text("Starting") }
            Text("Description")
                .tabItem { Text("Description") }
            Text("Description complemented")
                .tabItem { Text("Description") }
        }.tabViewStyle(PageTabViewStyle()).indexViewStyle(
            PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct PrincipalCarousel_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalCarousel()
    }
}
