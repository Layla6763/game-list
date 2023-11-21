//
//  GameListView.swift
//  GameList
//
//  Created by Jiayi Bian on 22/9/2023.
//

import SwiftUI
import CoreData

struct GameListView: View {
    @State private var name: String
    @State private var platform: Int
    @State private var status: Int
    
    public init(name: String, platform: Int, status: Int) {
        self._name = State(initialValue: name)
        self._platform = State(initialValue: platform)
        self._status = State(initialValue: status)
    }
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(
        entity: Game.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Game.id, ascending: true)]
    ) var games: FetchedResults<Game>
    
    private var platforms = ["Nintendo Switch", "PlayStation 4", "PlayStation 5", "Xbox One", "Xbox Series X/S", "Windows", "MacOS"]
    @State private var offsets = [CGSize](repeating: CGSize.zero, count: 1000)
    @State private var showAlert = false
    @State private var currentDeleteGameIndex = 0;
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.games.indices, id: \.self) { index in
                    if shouldShowGame(game: games[index]) {
                        VStack(alignment: .leading, spacing: 6) {
                        Text(games[index].name!)
                            .bold()
                            .padding(.top, 8)
                            .foregroundColor(.white)
                        
                        // Platform
                        Text("Platform: \(platforms[Int(games[index].platform)])")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        
                        // Release Year
                        Text(verbatim: "Release Year: \(games[index].releaseYear)")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            
                        // Estimate Time
                        Text("Estimate Time: \(String(format: "%.2f", games[index].estimateTime)) hours")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        
                        // Edit game and finish game buttons
                        HStack {
                            NavigationLink("Edit Game", destination: EditGameView(game: games[index]))
                                .frame(maxWidth: 110, alignment: .center)
                                .foregroundColor(.white)
                                .border(.white)
                                .padding(.vertical, 12)
                            // TODO: button for finishing the game and give the game a rating score
                            //                            Button("Finished game") {
                            //                            }
                            //                            .buttonStyle(BorderedButtonStyle()) // Add a border to the button
                            //                            .padding(.vertical, 5)
                            //                            .tint(.white)
                        }
                    }
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor.opacity(0.9))
                        .cornerRadius(10)
                        .padding([.vertical, .horizontal], 8)
                        .offset(x: offsets[index].width)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    // Prevent swipe to the right in default position
                                    if offsets[index].width == 0 && gesture.translation.width > 0 {
                                        return
                                    }
                                    
                                    self.offsets[index] = gesture.translation
                                }
                                .onEnded { gesture in
                                    if self.offsets[index].width < -80 {
                                        showAlert = true
                                        currentDeleteGameIndex = index
                                        return;
                                    } else {
                                        self.offsets[index] = .zero
                                        return
                                    }
                                }
                        )
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Delete Game"),
                                message: Text("Are you sure you want to delete this game?"),
                                primaryButton: .default(Text("Yes")) {
                                    // Delete the game
                                    let gameIndex = $currentDeleteGameIndex.wrappedValue
                                    managedObjContext.delete(games[gameIndex])
                                    DataController().save(context: managedObjContext)
                                    self.offsets.remove(at: gameIndex)
                                    return
                                },
                                secondaryButton: .cancel(
                                    Text("Cancel"),
                                    action: {
                                        let gameIndex = $currentDeleteGameIndex.wrappedValue
                                        self.offsets[gameIndex] = .zero
                                        return
                                    }
                                )
                            )
                        }
                    }
                }
             }
        }
    }
    
    private func shouldShowGame(game: Game) -> Bool {
        if name != "" && game.name != name {
            return false
        }
        
        if platform != 7 && game.platform != platform {
            return false
        }

        if status != 3 && game.status != status {
            return false
        }

        return true
    }
}
