//
//  GameView.swift
//  NefubApp
//
//  Created by Jasper Mutsaerts on 12/11/2022.
//

import NefubApi
import SwiftUI

struct GameView: View {
    var game: Game
    @ObservedObject var model = GameViewModel()

    var body: some View {
        VStack {
            List(model.events, id: \.time) { event in
                HStack(alignment: .top) {
                    Text(event.time ?? "-")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            if (event.hasGoalType) {
                                Image(systemName: "cricket.ball")
                            }
                            if let description = event.description {
                                Text(description)
                                    .font(.subheadline)
                            }
                            

                        }
                        if let code = event.code {
                            Text(code)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                }
            }
            Spacer()
            Text(game.getFormattedResult())
                .font(.largeTitle)
        }
        .onAppear {
            model.load(game)
        }
        .navigationTitle(game.name ?? "Unknown")
    }
}

class GameViewModel: ObservableObject {
    private var api = NefubApi()

    @Published var result: Result?
    @Published var events = [GameEvent]()



    func load(_ game: Game) {
        api.game(game.id) { game in
            self.events = game.events
            self.result = game.result
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game.preview)
    }
}
