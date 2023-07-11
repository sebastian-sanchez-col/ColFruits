//
//  ContentView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WelcomeView().padding()
            HStack {
                NumberCell(name: 1, isSelected: true)
                NumberCell(name: 2, isSelected: false)
            }.padding()
            ForEach(0 ..< 2) { index in
                FruitView(index: index)
            }
            Text("Third slide")
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
