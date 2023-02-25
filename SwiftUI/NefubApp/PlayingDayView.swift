//
//  PlayingDayView.swift
//  NefubApp
//
//  Created by Jasper Mutsaerts on 03/11/2022.
//

import NefubApi
import SwiftUI

struct PlayingDayView: View {
    var playingDay: PlayingDay

    @ObservedObject var model = PlayingDayViewModel()

    var body: some View {
        List(model.games) { game in
            HStack {
                NavigationLink(destination: GameView(game: game)) {
                    HStack {
                        Text(game.time ?? "TBA")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        TeamImage(game.home!, size: 25)
                        Text(game.home?.name ?? "Home")
                        Spacer()
                        Text(game.away?.name ?? "Away")
                        TeamImage(game.away!, size: 25)
                    }
                }
            }
        }
        .navigationTitle(playingDay.name ?? "")
        .onAppear {
            model.load(playingDay)
        }
    }
}

class PlayingDayViewModel: ObservableObject {
    private var api = NefubApi()
    @Published var games = [Game]()

    func load(_ playingDay: PlayingDay) {
        api.scheduled(date: playingDay.date) {
            self.games = $0
        }
    }
}

struct PlayingDayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingDayView(playingDay: PlayingDay(dateString: "22-10-2022")!)
    }
}
