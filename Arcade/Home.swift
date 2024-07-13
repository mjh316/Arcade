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
    @State var numSessions: Int?
    @State var totalMinutes: Int?
    
    var body: some View {
        VStack {
            HStack {
                Text("Arcade")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                Spacer()
            }
            Spacer()
            ZStack {
                if numSessions != nil {
                    Text("You've completed ")
                    +
                    Text("\(numSessions!) sessions ")
                        .foregroundStyle(.green)
                    +
                    Text("with a total of ")
                    +
                    Text("\(totalMinutes!) minutes!")
                        .foregroundStyle(.red)
                } else {
                    Text("You haven't completed any sessions.")
                }
            }.font(.title)
            
            Spacer()
        }.task {
            do {
                if numSessions == nil {
                    print("api settings: \(apiSettings.apiKey)")
                    let sessionData = try await apiSettings.getSession()
                    print("Session data: \(sessionData.data as ArcadeSession.SessionData?)")
                    let statsData = try await apiSettings.getStats()
                    print("Stats data: \(statsData.data as ArcadeStats.StatData)")
                    self.numSessions = statsData.data.sessions
                    self.totalMinutes = statsData.data.total
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}


#Preview {
    Home().environmentObject(API()).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
