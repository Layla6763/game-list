//
//  AddGameView.swift
//  GameList
//
//  Created by jiayi_work on 10/9/2023.
//

import SwiftUI

struct AddGameView: View {
    var body: some View {
        VStack {
            Text("Add game")
                .font(.system(size: 30, weight: .heavy))
            
            ToolbarView()
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

struct AddGameView_Previews: PreviewProvider {
    static var previews: some View {
        AddGameView()
    }
}
