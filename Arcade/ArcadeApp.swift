//
//  ArcadeApp.swift
//  Arcade
//
//  Created by Justin Huang on 7/8/24.
//

import SwiftUI
import SwiftData

@main
struct ArcadeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    APIData.self
            ])
        }
    }
}
