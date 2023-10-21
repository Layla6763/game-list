//
//  FilterGameView.swift
//  GameList
//
//  Created by jiayi_work on 19/10/2023.
//

import SwiftUI

struct FilterGameView: View {
    @State private var searchName = ""
    @State private var selectedPlatform = 7 // Default platform
    @State private var selectedStatus = 3 // Default status
    
    var platforms = ["Nintendo Switch", "PlayStation 4", "PlayStation 5", "Xbox One", "Xbox Series X/S", "Windows", "MacOS", "No platform"]
    var statuses = ["To play", "Playing", "Finished", "No status"];
    
    var body: some View {
        Form {
            Section(header: Text("Find game").font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(.accentColor)) {
                // Search game
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search for a game", text: $searchName)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                // Filter by platform
                Picker("Platform", selection: $selectedPlatform) {
                    ForEach(0..<platforms.count, id: \.self) {
                        Text(platforms[$0]).tag($0)
                    }
                }
                
                // Filter by Status
                Picker("Status", selection: $selectedStatus) {
                    ForEach(0..<statuses.count, id: \.self) {
                        Text(statuses[$0]).tag($0)
                    }
                }
                
                //Save Button
                NavigationLink("Search", destination: GameListView(name: searchName, platform: selectedPlatform, status: selectedStatus))
                    .frame(maxWidth: 120, alignment: .center)
                    .border(Color.accentColor)
                    .background(Color.accentColor)
                    .cornerRadius(5)
                    .opacity(0.8)
                    .padding(.vertical, 10)
            }
        }
    }
}

struct FilterGameView_Previews: PreviewProvider {
    static var previews: some View {
        FilterGameView()
    }
}
