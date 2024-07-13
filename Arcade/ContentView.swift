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
    @State var isSplashDone = false
    
    // pre-fetch data to pass down in loading if exists
    @State var numSessions: Int?
    @State var totalMinutes: Int?
    @State var historyData: [ArcadeHistory.HistoryData]?
    
    var body: some View {
        if !isSplashDone {
            // splash view
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                Image("hack-club-anime")
                    .resizable()
                    .frame(width: 300, height: 185)
            }.task {
                do {
                    loadModelData()
                    try await loadStatsData()
                    try await loadHistoryData()
                    // i love artificial ui
                    try await Task.sleep(for: .seconds(1))
                } catch {
                    print("error: \(error)")
                }
                isSplashDone = true
            }.environmentObject(apiSettings)
        } else {
            if apiSettings.apiKey == "" {
                Login().environmentObject(apiSettings)
                    .preferredColorScheme(.dark)
                    .animation(Animation.easeInOut(duration: 1.0), value: 1.0)
//                    .onAppear(perform: load)
            } else {
                TabView {
                    Home(numSessions: $numSessions, totalMinutes: $totalMinutes).tabItem { Label("Home", systemImage: "house.fill") }
                    History(historyData: $historyData).tabItem { Label("History", systemImage: "clock.fill") }
                    Settings().tabItem { Label("Settings", systemImage: "gearshape.fill") }
                }.environmentObject(apiSettings)
                    .preferredColorScheme(.dark)
                    .animation(Animation.easeInOut(duration: 1.0), value: 1.0)
                    .transition(.slide)
//                    .onAppear(perform: load)
            }
        }
    }
    
    func loadModelData() {
        let request = FetchDescriptor<APIData>()
        let data = try? modelContext.fetch(request)
        if data?.first != nil {
            let first = data?.first
            apiSettings.apiKey = first!.apiKey
            apiSettings.slackId = first!.slackId
            apiSettings.shopURL = first!.shopURL
        }
    }
    
    func loadStatsData() async throws {
        if apiSettings.apiKey == "" || apiSettings.slackId == "" {
            return
        }
        let stats = try await apiSettings.getStats()
        if (stats.ok) {
            numSessions = stats.data.sessions
            totalMinutes = stats.data.total
        } else {
            throw HackError.runtimeError("failed fetching stats data")
        }
    }
    
    func loadHistoryData() async throws {
        if apiSettings.apiKey == "" || apiSettings.slackId == "" {
            return
        }
        let history = try await apiSettings.getHistory()
        if (history.ok) {
            historyData = history.data
        } else {
            throw HackError.runtimeError("failed fetching history data")
        }
    }
}

enum HackError: Error {
    case runtimeError(String)
}

#Preview {
    ContentView().modelContainer(for: [APIData.self])
}
