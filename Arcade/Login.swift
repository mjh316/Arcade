//
//  Login.swift
//  Arcade
//
//  Created by Justin Huang on 7/12/24.
//

import Foundation
import SwiftUI

struct Login: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var apiSettings: API
    @State var apiKey: String = ""
    @State var slackID: String = ""
    @State var shopURL: String = ""
    
    @State var isRunning = false
    @State var fetchError = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack {
                    Image("orphmoji_yippee")
                        .resizable()
                        .frame(width: 124.12, height: 128)
                        .rotationEffect(.degrees(-20))
                    Spacer()
                    Image("orpheus-having-boba")
                        .resizable()
                        .frame(width: 125, height: 144)
                        .rotationEffect(.degrees(20))
                }.padding()
                Text("Welcome to Arcade Stats")
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .font(.title)
                Text("Please provide your connection information for the Hack Club API & Slack!")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .fontDesign(.rounded)
                    .padding(.horizontal, 10)
                
                Form {
                    Section(header: Text("Arcade API Key").fontDesign(.rounded)) {
                        TextField("xxxxxx-xxxx-xxxxx-xxxx-xxx", text: $apiKey)
                    }
                    Section(header: Text("Hack Club Slack Member ID").fontDesign(.rounded)) {
                        TextField("U0xxxxxxx", text: $slackID)
                    }
                    Section(header: Text("Arcade Shop URL").fontDesign(.rounded)) {
                        TextField("", text: $shopURL, prompt: Text(verbatim: "https://hackclub.com/arcade/[...]/shop/"))
                        
                    }
                }.scrollContentBackground(.hidden)
                    .padding(0)
                    .contentMargins(5)
//                    .border(.green)
                    .frame(maxHeight: 300)
                
                NavigationLink {
                    ArcadeInfoHowTo()
                } label: {
                    Text("Wondering how to find them? →")
                        .foregroundStyle(.hcRed)
                }
                
                Spacer()
                
                Button(action: {
                    isRunning = true
                    Task {
                        do {
                            let api = API()
                            api.apiKey = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
                            api.slackId = slackID.trimmingCharacters(in: .whitespacesAndNewlines)
                            api.shopURL = shopURL.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            // sanity check
                            // also note that this doesn't check shopurl
                            let session = try await api.getSession()
                            if (session.ok) {
                                try modelContext.delete(model: APIData.self)
                                modelContext.insert(APIData(apiKey: apiKey, slackId: slackID, shopURL: shopURL))
                                apiSettings.apiKey = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
                                apiSettings.slackId = slackID.trimmingCharacters(in: .whitespacesAndNewlines)
                                apiSettings.shopURL = shopURL.trimmingCharacters(in: .whitespacesAndNewlines)
                            } else {
                                fetchError = true
                            }
                        } catch {
                            print("error: \(error)")
                            fetchError = true
                        }
                        isRunning = false
                    }
                }, label: {
                    Text("Continue →")
                        .foregroundStyle(.white)
                        .frame(maxWidth: 500, maxHeight: 60)
                        .cornerRadius(9999)
    //                    .border(.green)
                        .background(.hcRed)
                        .opacity((isRunning || slackID == "" || apiKey == "" || shopURL == "") ? 0.5 : 1)
    //                    .padding(.horizontal, 20)
                        .clipShape(Capsule())
                        .fontWeight(.bold)
                        .font(.title2)
                        .opacity(isRunning ? 0.5 : 1)
                }).disabled(isRunning || slackID == "" || apiKey == "" || shopURL == "" )
                    .alert("Your information failed! Either double-check or try again later, if you've hit the rate limit.", isPresented: $fetchError) {
                        Button("OK", role: .cancel) {}
                    }
                Spacer(minLength: 10)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
            .multilineTextAlignment(.leading)
            .background(Color(.hc))
        }
    }
}


#Preview {
    Login().environmentObject(API())
        .preferredColorScheme(.dark)
}
