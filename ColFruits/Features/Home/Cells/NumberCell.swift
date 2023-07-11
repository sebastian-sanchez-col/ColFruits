//
//  NumberCell.swift
//  ColFruits
//
//  Created by Juan Sebastian Sanchez Mancilla on 9/05/23.
//

import SwiftUI

struct NumberCell: View {
    var name: Int
    var isSelected: Bool

    var body: some View {
        if isSelected {
            Text(String(name))
                .font(.largeTitle)
        } else {
            Text(String(name))
        }
    }
}

struct NumberCell_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            NumberCell(name: 1, isSelected: true)
            NumberCell(name: 2, isSelected: false)
        }
    }
}
