//
//  WelcomeView.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 5/05/23.
//

import SwiftUI
struct CardView: View, Identifiable {
    let id: Int
    let title: String
    let image: Image

    var body: some View {
      ZStack {
        image
          .resizable()
          .scaledToFill()

        Text(title)
          .font(.title)
          .foregroundColor(.white)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .cornerRadius(10)
      .shadow(radius: 10)
      .offset(x: -20, y: 0)
      .onAppear {
        withAnimation(.easeInOut(duration: 2)) {
          self.position(x: 20, y: .zero)
        }
      }
    }

    var hashValue: Int {
      return id.hashValue ^ title.hashValue
    }
  }
struct HomeView: View {
    @State private var cards = [
      CardView(id: 1, title: "Card 1", image: Image(systemName: "heart")),
      CardView(id: 2, title: "Card 2", image: Image(systemName: "star")),
      CardView(id: 3, title: "Card 3", image: Image(systemName: "moon")),
    ]

    var body: some View {
      VStack {
        ForEach(cards) { card in
          card
            .position(x: .zero, y: .zero)
        }
      }
    }
  }

//    var body: some View {
//        TabView {
//            ZStack {
//              Image(systemName: "heart")
//                Spacer()
//                    .frame(height: 20)
//                Image(systemName: "heart")
//                Spacer()
//                    .frame(height: 20)
//                Image(systemName: "heart")
//                Spacer()
//                    .frame(height: 20)
//                Image(systemName: "heart")
//            }
//            Text("Welcome \nto colombian fruits")
//            HStack {
//                NumberCell(name: 1, isSelected: true)
//                NumberCell(name: 2, isSelected: false)
//            }.padding()
//            ForEach(0 ..< 2) { index in
//                FruitView(index: index)
//            }
//            Text("Third slide")
//        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//    }

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
