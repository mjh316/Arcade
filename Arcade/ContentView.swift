//
//  ContentView.swift
//  Arcade
//
//  Created by Justin Huang on 7/8/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject var apiSettings = API()

    var body: some View {
        TabView {
            Home().tabItem { Label("Home", systemImage: "house.fill") }
            History().tabItem { Label("History", systemImage: "clock.fill") }
            Settings().tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }.environmentObject(apiSettings)
            .preferredColorScheme(.dark)
            .animation(Animation.easeInOut(duration: 1.0), value: 1.0)
            .transition(.slide)
            .onAppear(perform: load)
    }
    
    func load() {
        let request = FetchDescriptor<APIData>()
        let data = try? modelContext.fetch(request)
        if data?.first != nil {
            let first = data?.first
            apiSettings.apiKey = first!.apiKey
            apiSettings.slackId = first!.slackId
        }
    }
}

#Preview {
    ContentView().modelContainer(for: [APIData.self])
}
