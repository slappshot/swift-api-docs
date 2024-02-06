//
//  ContentView.swift
//  NefubApp
//
//  Created by Jasper Mutsaerts on 02/11/2022.
//

import NefubApi
import SwiftUI

struct ContentView: View {
    @ObservedObject var model = LocationsModel()

    var isLoading: Bool {
        model.locations == nil
    }

    var locations: [Location] {
        model.locations ?? []
    }

    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Loading...")
            } else if locations.isEmpty {
                Text("No locations found")
            } else {
                List {
                    ForEach(locations, id: \.id) { location in
                        NavigationLink(destination: LocationView(location: location).macOsNavigationView()) {
                            VStack(alignment: .leading) {
                                Text(location.name ?? "")
                                    .lineLimit(1)
                                Text(location.id.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }

                    }
                }
            }
        }
        .onAppear(perform: model.load)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
    }
}

class LocationsModel: ObservableObject {
    @Published var locations: [Location]?

    private var api: NefubApi {
        NefubApi()
    }

    func load() {
        api.playingDays(seasonId: 2022) { playingDays in
            var locations: [Location] = []
            playingDays
                .flatMap { $0.locations }
                .forEach { location in
                    if !locations.contains(location) {
                        locations.append(location)
                    }
                }
            self.locations = locations.sorted {
                $0.name! < $1.name!
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = LocationsModel()
        let location = Location(id: 1)
        location.name = "Nieuw Welgelegen"

        model.locations = [
            location
        ]
        return ContentView(model: model)
    }
}
