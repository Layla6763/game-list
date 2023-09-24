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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id, order: .reverse)]) var game: FetchedResults<Game>
    
    private var platforms = ["Nintendo Switch", "PlayStation 4", "PlayStation 5", "Xbox One", "Xbox Series X/S", "Windows", "MacOS"]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(game) { game in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(game.name!)
                            .bold()
                            .padding(.top, 8)
                            .foregroundColor(.white)
                        Text("Platform: \(platforms[Int(game.platform)])")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        Text(verbatim: "Release Year: \(game.releaseYear)")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        Text("Estimate Time: \(String(format: "%.2f", game.estimateTime)) hours")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor.opacity(0.8))
                    .cornerRadius(10)
                    .padding([.vertical, .horizontal], 8)
                }
            }
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
