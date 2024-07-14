//
//  Sessions.swift
//  Arcade
//
//  Created by Justin Huang on 7/10/24.
//

import Foundation
import SwiftUI

struct History: View {
    @EnvironmentObject var apiSettings: API
    @Binding var historyData: [ArcadeHistory.HistoryData]?
    
    let history: [ArcadeHistory.HistoryData] = [
        ArcadeHistory.HistoryData(createdAt: "2024-06-23T02:49:17.900Z", time: 42, elapsed: 60, goal: "IPad!", ended: true, work: "Sunshine Interpreter Part 1"),
        ArcadeHistory.HistoryData(createdAt: "2024-06-23T02:49:17.900Z", time: 42, elapsed: 60, goal: "IPad!", ended: true, work: "Sunshine Interpreter Part 1"),
        ArcadeHistory.HistoryData(createdAt: "2024-06-23T02:49:17.900Z", time: 42, elapsed: 60, goal: "IPad!", ended: true, work: "Sunshine Interpreter Part 1"),
        ArcadeHistory.HistoryData(createdAt: "2024-06-23T02:49:17.900Z", time: 42, elapsed: 60, goal: "IPad!", ended: true, work: "Sunshine Interpreter Part 1")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("flag-orpheus-left")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 244, maxHeight: 129)
                    .offset(x: -100, y: 5)
                HStack {
                    Text("Sessions")
                        .font(.system(size: 40))
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    Spacer()
                }.padding(.horizontal, 50)
                ScrollView {
                    LazyVStack(alignment: .leading, content: {
                        ForEach(historyData?.sorted {$0.createdAt > $1.createdAt} ?? [], id: \.createdAt) { session in
                            NavigationLink {
                                SessionDetail(sessionData: session)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.hcDark)
                                    HStack {
                                        VStack {
                                            HStack {
                                                Text(verbatim: session.work)
                                                    .fontWeight(.bold)
                                                    .foregroundStyle(.white)
                                                Spacer()
                                            }
                                            HStack {
                                                Text(session.createdAt)
                                                    .foregroundStyle(.white)
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                        Text("→")
                                        .foregroundStyle(.white)
                                    }.padding()
                                }
                            }
                        }
                    })
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 50)
                //            HStack {
                //                Text("History")
                //                    .font(.largeTitle)
                //                    .fontWeight(.bold)
                //                    .padding(.horizontal, 40)
                //                    .padding(.vertical, 20)
                //                Spacer()
                //            }
                //            Spacer()
                //            ScrollView {
                //                if historyData != nil {
                //                    VStack {
                //                        ForEach(historyData!, id: \.createdAt) { history in
                //                            HStack {
                //                                Text(history.work)
                //                                    .multilineTextAlignment(.leading)
                //                                Spacer()
                //                            }
                //                        }
                //                        .multilineTextAlignment(.leading)
                //                        .padding(.horizontal, 10)
                //                    }
                //                }
                //            }.padding(.horizontal, 40)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(.hc)
            .task {
                do {
                    if historyData == nil  {
                        let historyData = try await apiSettings.getHistory()
                        print("History data: \(historyData.data  as [ArcadeHistory.HistoryData]?)")
                        if historyData.ok {
                            self.historyData = historyData.data ?? []
                        }
                    }
                } catch {
                    print("Error in History: \(error)")
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var historyData: [ArcadeHistory.HistoryData]?
        var body: some View {
            History(historyData: $historyData)
                .environmentObject(API())
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
    return Preview()
}
