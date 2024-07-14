//
//  Home.swift
//  Arcade
//
//  Created by Justin Huang on 7/9/24.
//

import Foundation
import SwiftUI

func calculateFunFact(_ totalMinutes: Int?) -> String {
    if totalMinutes == nil {
        return "nothing"
    }
    
    return String(totalMinutes! / 260) + " marathons"
}

struct Home: View {
    @EnvironmentObject var apiSettings: API
    @Binding var numSessions: Int?
    @Binding var totalMinutes: Int?
    @State var apiStatus = ""
    
    func getAPIStatus() async throws {
        let data = try await API.getStatusCheck()
        if !data.airtableConnected {
            apiStatus += "Error: Airtable not connected"
        }
        if !data.slackConnected {
            apiStatus += apiStatus.count > 0 ? " and Slack not connected" : "Error: Slack not connected"
        }
        
        if data.airtableConnected && data.slackConnected {
            apiStatus = "Slack and Airtable connected"
        }
        
        apiStatus += "!"
    }
    
    var body: some View {
        VStack {
            Image("flag-orpheus-left")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 244, maxHeight: 129)
                .offset(x: -100, y: 5)
//                .ignoresSafeArea()
//                .position(x: 100, y: 0)
//                .border(.green)
            HStack {
                Text("Arcade")
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                Spacer()
            }.padding(.horizontal, 50)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.hcDark)
                VStack {
                    Text("So far this summer, you’ve played in Arcade a total of…")
                        .fontWeight(.bold)
                        .font(.title2)
                        .fontDesign(.rounded)
                    Spacer()
                    VStack {
                        HStack {
                            VStack {
                                HStack {
                                    Text(String(totalMinutes ?? 0))
                                        .font(.system(size: 64))
                                        .fontWeight(.heavy)
                                        .foregroundStyle(.hcRed)
                                    Spacer()
                                }
                                HStack {
                                    Text("minutes")
                                        .font(.system(size: 32))
                                        .offset(y: -10)
                                    Spacer()
                                }
                            }
                        }
                        
                        HStack {
                            VStack {
                                HStack {
                                    Text(String(numSessions ?? 0))
                                        .font(.system(size: 48))
                                        .fontWeight(.heavy)
                                        .foregroundStyle(.hcAccent)
                                    Spacer()
                                }
                                HStack {
                                    Text("sessions")
                                        .font(.system(size: 24))
                                        .offset(y: -10)
                                    Spacer()
                                }
                            }
                        }
                    }
                    Spacer()
                    
                    HStack {
                        Text(totalMinutes == 0 ? "No better time to start than the present. Visit #arcade in the slack to start playing anytime! Bon voyage 🧑‍🍳" : "That's about as much as \(calculateFunFact(totalMinutes))! Make sure to congratulate yourself and remember to rest!")
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(
                                apiStatus == "" ?
                                Color.yellow.shadow(.drop(color: .yellow, radius: 7.5)) :
                                    apiStatus.starts(with: "Error")
                                ?
                                    Color.red.shadow(.drop(color: .red, radius: 7.5))
                                :
                                Color.green.shadow(.drop(color: .green, radius: 7.5)))
                        Text("Status: " + (apiStatus == "" ? "Loading..." : apiStatus))
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                        Spacer()
                    }
//                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .task {
                        do {
                            print("getting api status")
                            try await getAPIStatus()
                        } catch {
                            print("Error in api check timer: \(error)")
                        }
                    }
                    .onAppear {
                        print("scheduling timer…")
                        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
                            Task { 
                                do {
                                    print("getting api status")
                                    try await getAPIStatus()
                                } catch {
                                    print("Error in api check timer: \(error)")
                                }
                            }
                        }
                    }
                }.padding(20)
            }.padding(.horizontal, 30)
            Spacer()
//            HStack {
//                Text("Arcade")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.horizontal, 40)
//                    .padding(.vertical, 20)
//                Spacer()
//            }
//            Spacer()
//            ZStack {
//                if numSessions != nil {
//                    Text("You've completed ")
//                    +
//                    Text("\(numSessions!) sessions ")
//                        .foregroundStyle(.green)
//                    +
//                    Text("with a total of ")
//                    +
//                    Text("\(totalMinutes!) minutes!")
//                        .foregroundStyle(.red)
//                } else {
//                    Text("You haven't completed any sessions.")
//                }
//            }.font(.title)
//            
//            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.hc)
        .task {
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
    struct Preview: View {
        @State var numSessions: Int? = 0
        @State var totalMinutes: Int? = 0
        var body: some View {
            Home(numSessions: $numSessions, totalMinutes: $totalMinutes).environmentObject(API()).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
    return Preview()
}
