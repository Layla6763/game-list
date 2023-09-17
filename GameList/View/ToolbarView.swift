//
//  ToolbarView.swift
//  GameList
//
//  Created by jiayi_work on 10/9/2023.
//

import SwiftUI

struct ToolbarView: View {
    var body: some View {
        HStack {
            Button(action: {
                // Handle the "Add" button action here
            }) {
                Image(systemName: "plus.circle.fill") // Use SF Symbol for the "Add" button
                    .font(.system(size: 36))
            }
            Button(action: {
                // Handle the "Filter" button action here
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle.fill") // Use SF Symbol for the "Filter" button
                    .font(.system(size: 36))
            }
            Spacer()
        }
        .padding([.horizontal, .vertical], 6)
        .background(Color.accentColor)
        .foregroundColor(.white)
    }
}


