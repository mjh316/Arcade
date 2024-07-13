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
    var body: some View {
        VStack {
            HStack {
                Text("History")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                Spacer()
            }
            Spacer()
            ScrollView {
                if historyData != nil {
                    VStack {
                        ForEach(historyData!, id: \.createdAt) { history in
                            HStack {
                                Text(history.work)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 10)
                    }
                }
            }.padding(.horizontal, 40)
        }.task {
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
