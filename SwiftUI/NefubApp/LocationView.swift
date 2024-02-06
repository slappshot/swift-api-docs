//
//  LocationView.swift
//  NefubApp
//
//  Created by Jasper Mutsaerts on 02/11/2022.
//

import NefubApi
import SwiftUI

struct LocationView: View {
    var imageSize = 300
    var location: Location
    @State var image: Image?
    @ObservedObject var model = LocationViewModel()

    var body: some View {
        VStack {
            LocationImage(location.id, size: imageSize)
            Spacer()
            List(model.playingDays) { playingDay in
                NavigationLink(destination: PlayingDayView(playingDay: playingDay)) {
                    Text(playingDay.name!)
                }
            }
        }
        .onAppear {
            model.load(location)
        }
        .navigationTitle(location.name ?? "Unknown")
    }
}

class LocationViewModel: ObservableObject {
    private var api = NefubApi()
    @Published var playingDays = [PlayingDay]()

    func load(_ location: Location) {
        api.playingDays(locationId: location.id) {
            self.playingDays = $0
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(location: Location.preview)
    }
}
