//
//  FilterGameView.swift
//  GameList
//
//  Created by jiayi_work on 19/10/2023.
//

import SwiftUI

struct FilterGameView: View {
    @State private var searchName = ""
    @State private var selectedPlatform = 0 // Default platform
    @State private var selectedReleaseYear = 2023 // Default release year
    @State private var selectedStatus = 0 // Default status
    
    var platforms = ["Nintendo Switch", "PlayStation 4", "PlayStation 5", "Xbox One", "Xbox Series X/S", "Windows", "MacOS"]
    var statuses = ["To play", "Playing", "Finished"];
    
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
                
                // Filter by release Year
                Picker("Release Year", selection: $selectedReleaseYear) {
                    ForEach(1900...2100, id: \.self) {
                        Text(String($0))
                    }
                }
                
                // Filter by Status
                Picker("Status", selection: $selectedStatus) {
                    ForEach(0..<statuses.count, id: \.self) {
                        Text(statuses[$0]).tag($0)
                    }
                }
                
                //Save Button
                Section {
                    Button("Search") {
                        
                    }
                    .buttonStyle(BorderedButtonStyle()) // Add a border to the button
                    .frame(maxWidth: .infinity, alignment: .center) // Center the button
                    .padding(.vertical, 6)
                }
            }
        }
    }
}

struct FilterGameView_Previews: PreviewProvider {
    static var previews: some View {
        FilterGameView()
    }
}
