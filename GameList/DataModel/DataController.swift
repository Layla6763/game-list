//
//  DataController.swift
//  GameList
//
//  Created by jiayi_work on 18/9/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "GameModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Failed to save data")
        }
    }
    
    func addGame(name: String, platform: Int16, releaseYear: Int16, estimateTime: Double, notes: String, status: Int16, ratingScore: Double, context:NSManagedObjectContext) {
        let game = Game(context: context)
        game.id = UUID()
        game.name = name
        game.platform = platform
        game.releaseYear = releaseYear
        game.estimateTime = estimateTime
        game.notes = notes
        game.status = status
        game.ratingScore = ratingScore
        
        save(context: context)
    }
    
    func editGame(game: Game, name: String, platform: Int16, releaseYear: Int16, estimateTime: Double, notes: String, status: Int16, ratingScore: Double, context:NSManagedObjectContext) {
        game.name = name
        game.platform = platform
        game.releaseYear = releaseYear
        game.estimateTime = estimateTime
        game.notes = notes
        game.status = status
        game.ratingScore = ratingScore
        
        save(context: context)
    }
}
