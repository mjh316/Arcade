//
//  Home.swift
//  Arcade
//
//  Created by Justin Huang on 7/9/24.
//

import Foundation
import SwiftUI

struct Home: View {
    @EnvironmentObject var apiSettings: API
    @State var numSessions: Int = 0
    @State var totalMinutes: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Arcade")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 40)
                Spacer()
            }
            Spacer()
            ZStack {
                Text("You've completed ")
                +
                Text("\(numSessions) sessions ")
                    .foregroundStyle(.green)
                +
                Text("with a total of ")
                +
                Text("\(totalMinutes) minutes!")
                    .foregroundStyle(.red)
            }.font(.title)
            
            Spacer()
        }.task {
            do {
                print("api settings: \(apiSettings.apiKey)")
                let sessionData = try await apiSettings.getSession()
                print("Session data: \(sessionData.data as ArcadeSession.SessionData?)")
                let statsData = try await apiSettings.getStats()
                print("Stats data: \(statsData.data as ArcadeStats.StatData)")
                self.numSessions = statsData.data.sessions
                self.totalMinutes = statsData.data.total
            } catch {
                print("Error: \(error)")
            }
        }
    }
}


#Preview {
    Home().environmentObject(API()).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
