//
//  Previews.swift
//  NefubApp
//
//  Created by Jasper Mutsaerts on 02/11/2022.
//

import NefubApi

extension Location {
    static var preview: Location {
        let location = Location(id: 1)
        location.name = "Nieuw Welgelegen"

        return location
    }

    fileprivate static var secondaryPreview: Location {
        let location = Location(id: 2)
        location.name = "Olympos"

        return location
    }
}

extension Game {
    static var preview: Game {
        let game = Game(id: 1)
        game.result = Result(home: 5, away: 9)
        game.home = Team.preview
        game.away = Team.secondaryPreview
        return game
    }
}

extension Team {
    static var preview: Team {
        let team = Team(id: 1)
        team.name = "UFC Utrecht"

        return team
    }

    fileprivate static var secondaryPreview: Team {
        let team = Team(id: 2)
        team.name = "FB Agents"

        return team
    }
}

extension Array where Element == Location {
    static var preview: [Location] {
        [
            Location.preview,
            Location.secondaryPreview
        ]
    }
}
