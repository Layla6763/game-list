//
//  GameListApp.swift
//  GameList
//
//  Created by jiayi_work on 10/9/2023.
//

import SwiftUI

@main
struct GameListApp: App {
    @StateObject private var dataController = DataController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
