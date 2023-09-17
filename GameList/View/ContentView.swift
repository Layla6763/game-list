//
//  ContentView.swift
//  GameList
//
//  Created by jiayi_work on 10/9/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddGameView = false
    var body: some View {
        NavigationStack {
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
                            showAddGameView = true
                        }
                    }
            }
            .navigationDestination(isPresented: $showAddGameView) {
                AddGameView()
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
