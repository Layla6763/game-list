//
//  GameListView.swift
//  GameList
//
//  Created by jiayi_work on 22/9/2023.
//

import SwiftUI
import CoreData

struct GameListView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id, order: .reverse)]) var games: FetchedResults<Game>
    
    private var platforms = ["Nintendo Switch", "PlayStation 4", "PlayStation 5", "Xbox One", "Xbox Series X/S", "Windows", "MacOS"]
    @State private var offsets = [CGSize](repeating: CGSize.zero, count: 6)
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.games.indices, id: \.self) { index in
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
                                    managedObjContext.delete(games[index])
                                    DataController().save(context: managedObjContext)
                                    self.offsets.remove(at: index)
                                    return
                                } else {
                                    self.offsets[index] = .zero
                                    return
                                }
                            }
                    )
                }
             }
        }
    }
}
