//
//  ArcadeInfoHowTo.swift
//  Arcade
//
//  Created by Justin Huang on 7/12/24.
//

import Foundation
import SwiftUI

struct ArcadeInfoHowTo: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Finding Connection Info")
                        .fontWeight(.bold)
                        .font(.title).fontDesign(.rounded)
                    Spacer()
                }
                .padding(.vertical, 10)
                Section {
                    Text("Just run /api in #arcade. Note that anyone with this can access the api as you!").padding(.bottom, 10)
                } header: {
                    HStack {
                        Text("Arcade API Key")
                            .font(.title3)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                Section {
                    HStack {
                        Text("Use the “Display IDs” command to find your Member ID, NOT your Workspace ID.")
                        Spacer()
                    }
                    Image("arcadeIDHowTo")
                        .resizable()
                        .frame(maxWidth: 200, maxHeight: 400)
                } header: {
                    HStack {
                        Text("Hack Club Slack Member ID")
                            .font(.title3)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                
                Section {
                    Text("Run /shop in #arcade on the Slack, and then copy the url from the browser. Note that anyone who has this url or your AirTable ID can access the Arcade shop as you!").padding(.bottom, 10)
                } header: {
                    HStack {
                        Text("Arcade Shop URL")
                            .font(.title3)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                
                
            }
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .padding()
            .background(.hc)
            .preferredColorScheme(.dark)
    }
}


#Preview {
    ArcadeInfoHowTo()
}
