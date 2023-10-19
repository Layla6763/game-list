//
//  EditGameView.swift
//  GameList
//
//  Created by jiayi_work on 2/10/2023.
//

import SwiftUI

struct EditGameView: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    // To take us back to the main view
    @Environment (\.dismiss) var dismiss
    
    var game : FetchedResults<Game>.Element
    
    @State private var name = ""
    @State private var platform = 0
    @State private var releaseYear = 2023
    @State private var estimateTime = ""
    @State private var notes = ""
    @State private var status = 0
    @State private var ratingScore = ""
    
    var platforms = ["Nintendo Switch", "PlayStation 4", "PlayStation 5", "Xbox One", "Xbox Series X/S", "Windows", "MacOS"]
    var statuses = ["To play", "Playing", "Finished"];
    
    var body: some View {
        Form {
            Section(header: Text("Edit Game").font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(.accentColor)) {
                // Game Name
                HStack {
                    Text("Name")
                    TextField("\(game.name!)", text: $name)
                        .multilineTextAlignment(.trailing)
                        .onAppear{
                            name = game.name ?? "Game Name"
                            platform = Int(game.platform)
                            releaseYear = Int(game.releaseYear)
                            estimateTime = String(game.estimateTime)
                            notes = game.notes ?? "Notes"
                            status = Int(game.status)
                            ratingScore = String(game.ratingScore)
                        }
                }
                
                // Platform
                Picker("Platform", selection: $platform) {
                    ForEach(0..<platforms.count, id: \.self) {
                        Text(platforms[$0]).tag($0)
                    }
                }
                
                // Release Year
                Picker("Release Year", selection: $releaseYear) {
                    ForEach(1900...2100, id: \.self) {
                        Text(String($0))
                    }
                }
                
                // Estimated Time
                HStack {
                    Text("Estimated Time")
                    TextField("0", text: $estimateTime)
                        .keyboardType(.decimalPad) // Allow decimal input
                        .multilineTextAlignment(.center)
                    Text("hours")
                }
                
                // Status
                Picker("Status", selection: $status) {
                    ForEach(0..<statuses.count, id: \.self) {
                        Text(statuses[$0]).tag($0)
                    }
                }
                
                // Rating score
                HStack {
                    Text("Rating Score")
                    TextField("0", text: $ratingScore)
                        .keyboardType(.decimalPad) // Allow decimal input
                        .multilineTextAlignment(.trailing)
                }
                
                // Notes
                Text("Notes")
                    .frame(alignment: .leading)
                TextEditor(text: $notes)
                    .frame(minHeight: 150) // Set the minimum height for the text editor
                    .background(Color(.systemGray5)) // Add a background color
                    .cornerRadius(8) // Add rounded corners
                    .listRowSeparator(.hidden)
                
                //Save Button
                Section {
                    Button("Submit") {
                        DataController().editGame(game: game, name: name, platform: Int16(platform), releaseYear: Int16(releaseYear), estimateTime: Double(estimateTime) ?? 0, notes: notes, status: Int16(status), ratingScore: Double(ratingScore) ?? 0, context: managedObjectContext)
                        dismiss()
                    }
                    .buttonStyle(BorderedButtonStyle()) // Add a border to the button
                    .frame(maxWidth: .infinity, alignment: .center) // Center the button
                    .padding(.vertical, 6)
                }
            }
        }
    }
}
