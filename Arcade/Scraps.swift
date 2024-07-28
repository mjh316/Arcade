//
//  Scraps.swift
//  Arcade
//
//  Created by Justin Huang on 7/27/24.
//

import Foundation
import SwiftUI

struct Scraps: View {
    @EnvironmentObject var apiSettings: API
    @State var scrapbookUser: ScrapbookUser? = nil
    
    var body: some View {
        VStack {
            
        }.task {
            guard let myUrl = URL(string: "https://scrapbook.hackclub.com/api/users") else {
                print("Error: the scrapbook api url doesn't seem to be valid")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: myUrl)
                let scrapbookUsers: [ScrapbookUser] = try JSONDecoder().decode([ScrapbookUser].self, from: data)
                for user in scrapbookUsers {
                    if user.slackID == apiSettings.slackId {
                        scrapbookUser = user
                        break
                    }
                }
            } catch {
                print("Error fetching scrapbook data: \(error)")
            }
            
        }
    }
}


#Preview {
    Scraps()
}
