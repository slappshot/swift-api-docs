//
//  NefubAppApp.swift
//  NefubApp
//
//  Created by Jasper Mutsaerts on 02/11/2022.
//

import NefubApi
import SwiftUI

@main
struct NefubAppApp: App {
    init() {
        NefubApi.configuration = .init(appVersion: "1.0.0", sdk: "1.0.0", deviceId: "xxx", osVersion: "12.0.0", personId: nil)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct MacOsNavigationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        #if os(macOS)
        NavigationView {
            content
        }
        #else
        content
        #endif
    }
}

extension View {
    func macOsNavigationView() -> some View {
        modifier(MacOsNavigationViewModifier())
    }
}
