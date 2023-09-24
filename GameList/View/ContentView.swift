//
//  ContentView.swift
//  GameList
//
//  Created by jiayi_work on 10/9/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showNavigationView = false
    @State private var path = NavigationPath()
    var body: some View {
        if showNavigationView {
            NavigationStack(path: $path) {
                VStack {
                    // Add new game
                    Spacer()
                    Button(action: {
                        path.append("addGameView")
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 36))
                        Text("Add New Game")
                            .frame(width: 200, height: 50)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    // Game list
                    Spacer()
                    Button(action: {
                        path.append("gameListView")
                    }) {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 36))
                        Text("Game List")
                            .frame(width: 200, height: 50)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    // Find Game
                    Spacer()
                    Button(action: {
                        //path.append("gameListView")
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 36))
                        Text("Find Game")
                            .frame(width: 200, height: 50)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    // Current Games
                    Spacer()
                    Button(action: {
                        //path.append("gameListView")
                    }) {
                        Image(systemName: "gamecontroller")
                            .font(.system(size: 36))
                        Text("Current Games")
                            .frame(width: 200, height: 50)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .navigationDestination(for: String.self) { route in
                    switch route {
                    case "addGameView":
                        AddGameView()
                    case "gameListView":
                        GameListView()
                    default:
                        EmptyView()
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        } else {
            VStack {
                Image(systemName: "gamecontroller")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.accentColor)
                Text("My Game Plan")
                    .font(.system(size: 30, weight: .heavy))
                    .onAppear {
                        // Start a timer to show the next view after 2 seconds
                        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                            showNavigationView = true
                        }
                    }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
