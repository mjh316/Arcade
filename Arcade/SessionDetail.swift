//
//  SessionDetail.swift
//  Arcade
//
//  Created by Justin Huang on 7/14/24.
//

import Foundation
import SwiftUI

struct SessionDetail: View {
    let sessionData: ArcadeHistory.HistoryData
    let dateFormatter = ISO8601DateFormatter()
    
    var body: some View {
        VStack {
            Image("flag-orpheus-left")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 244, maxHeight: 129)
                .offset(x: -100, y: 5)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.hcDark)
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                Text(sessionData.work)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                Spacer()
                            }
                            HStack {
                                Text(sessionData.createdAt)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                    
//                    Spacer()
                    VStack {
                        Text(String(sessionData.elapsed) + " minutes ")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.hcAccent)) +
                        Text(" elapsed out of ")
                            .font(.title)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                        +
                        Text(String(sessionData.time) + " minutes!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.hcRed)
                    }.padding(.vertical)
                    
                    Text("The goal for this session was: \(sessionData.goal)")
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                    
                    Image("orpheus-skateboarding-PCB")
                        .resizable()
                        .frame(width: 256)
                    Text("Orpheus says: Keep up the rad work!")
                        .fontDesign(.rounded)
                        .fontWeight(.medium)
//                    Spacer()
                    Spacer()
                }.padding()
            
            }
            .padding(30)
                
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
        .background(.hc)
    }
}

#Preview {
    SessionDetail(sessionData: ArcadeHistory.HistoryData(createdAt: "2024-06-23T02:49:17.900Z", time: 42, elapsed: 60, goal: "IPad!", ended: true, work: "Sunshine Interpreter Part 1"))
}
