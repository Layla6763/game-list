//
//  AddGameView.swift
//  GameList
//
//  Created by Jiayi Bian on 10/9/2023.
//

import SwiftUI

struct AddGameView: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    // To take us back to the main view
    
    @State private var name = ""
    @State private var platform = 0
    @State private var releaseYear = 2023
    @State private var estimateTime = ""
    @State private var notes = ""
    @State private var status = 0
    @State private var ratingScore: Double = 0
    
    @State private var isFormSubmitted = false
    private var platforms = ["Nintendo Switch", "PlayStation 4", "PlayStation 5", "Xbox One", "Xbox Series X/S", "Windows", "MacOS"]
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("New Game").font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(.accentColor)) {
                    // Game Name
                    HStack {
                        Text("Name")
                        TextField("Game Name", text: $name)
                            .multilineTextAlignment(.trailing)
                            .disableAutocorrection(true)
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
                        TextField("0", value: $estimateTime, formatter: NumberFormatter())
                            .keyboardType(.decimalPad) // Allow decimal input
                            .multilineTextAlignment(.center)
                            .disableAutocorrection(true)
                        Text("hours")
                    }
                    
                    // Notes
                    Text("Notes")
                        .frame(alignment: .leading)
                    TextEditor(text: $notes)
                        .frame(minHeight: 150) // Set the minimum height for the text editor
                        .background(Color(.systemGray5)) // Add a background color
                        .cornerRadius(8) // Add rounded corners
                        .listRowSeparator(.hidden)
                        .disableAutocorrection(true)
                    
                    //Save Button
                    Section {
                        Button("Save") {
                            DataController.shared.addGame(name: name, platform: Int16(platform), releaseYear: Int16(releaseYear), estimateTime: Double(estimateTime) ?? 0, notes: notes, status: Int16(status), ratingScore: ratingScore, context: managedObjectContext)
                            isFormSubmitted = true
                        }
                        .buttonStyle(BorderedButtonStyle()) // Add a border to the button
                        .frame(maxWidth: .infinity, alignment: .center) // Center the button
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("Add Game")
            .alert(isPresented: $isFormSubmitted) {
                Alert(
                    title: Text("New Game Saved"),
                    message: Text("Your game has been saved."),
                    dismissButton: .default(Text("OK")) {
                        // Reset the form by clearing the input fields
                        name = ""
                        platform = 0
                        releaseYear = 2023
                        estimateTime = ""
                        notes = ""
                    }
                )
            }
        }
    }
}

struct AddGameView_Previews: PreviewProvider {
    static var previews: some View {
        AddGameView()
    }
}
