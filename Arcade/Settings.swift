//
//  Profile.swift
//  Arcade
//
//  Created by Justin Huang on 7/8/24.
//

import Foundation
import SwiftUI

struct Settings: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var apiSettings: API
    
    var body: some View {
        NavigationStack {
            Text("API KEY: \(apiSettings.apiKey)")
            Form {
                Section(header: Text("Keys")) {
                    TextField(text: $apiSettings.apiKey, prompt: Text("API Key")) {
                        Text("API Key")
                    }
                    TextField(text: $apiSettings.slackId, prompt: Text("Slack Member ID")) {
                        Text("Slack Member ID")
                    }
                    Button(action: {
                        print("Starting to save API data...")
                        do {
                            try modelContext.delete(model: APIData.self)
                            modelContext.insert(APIData(apiKey: apiSettings.apiKey, slackId: apiSettings.slackId))
                            try modelContext.save()
                        } catch {
                            print("Failed to save api data")
                        }
                        print("Saved API data!")
                    }, label: {
                        Text("Save")
                    })
                    .disabled(apiSettings.apiKey.isEmpty || apiSettings.slackId.isEmpty)
                }
            }
        }.preferredColorScheme(.dark)
//        VStack{
//            Spacer()
//            VStack {
//                HStack {
//                    Text("Arcade Profile Settings").padding(.horizontal)
//                        .font(.title)
//                    Spacer()
//                }.padding(.horizontal)
//                VStack {
//                    TextField("Arcade API Key", text: $apiKeyInput)
//                        .padding()
//                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white))
//                        .padding()
//                        .multilineTextAlignment(.leading)
//                }
//                TextField("User Slack ID", text: $slackID)
//                    .padding()
//                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white))
//                    .padding()
//            }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
//            Spacer()
//        }
    }
}

#Preview {
    Settings().environmentObject(API())
}
