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
                        TextField("hackclub.com/arcade/[airtableID]/shop/", text: $shopURL)
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
                
                Button("Continue", systemImage: "arrow.right") {
                    
                }
                    .foregroundStyle(.white)
                    .frame(maxWidth: 500, maxHeight: 60)
                    .cornerRadius(9999)
//                    .border(.green)
                    .background(.hcRed)
//                    .padding(.horizontal, 20)
                    .clipShape(Capsule())
                    .fontWeight(.bold)
                    .font(.title2)
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
