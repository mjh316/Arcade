//
//  Scraps.swift
//  Arcade
//
//  Created by Justin Huang on 7/27/24.
//

import Foundation
import SwiftUI
//
//export interface PostType {
//  id: string;
//  user: UserType;
//  timestamp: number;
//  slackUrl: string | null;
//  postedAt: Date;
//  text: string;
//  attachments: string[];
//  mux: string[];
//  reactions: ReactionType[];
//}
//
//export interface ReactionType {
//  name: string;
//  usersReacted: string[];
//  url?: string;
//  char?: string;
//}



struct ScrapView: View {
    @State var scrapData: PostType
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.hcDark)
                VStack {
                    //AsyncImage(url: URL(string: item.imageURL)) { image in
//                    image.resizable()
//                } placeholder: {
//                    ProgressView()
//                }
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 50, height: 50)
                    Text(try! AttributedString(markdown: scrapData.text ?? ""))
                    Text(scrapData.postedAt)
                    if scrapData.attachments.count > 0 {
                        AsyncImage(url: URL(string: scrapData.attachments[0])) {image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 256, height: 128)
                        
                    }
                }.padding()
            }.padding(.horizontal, 50)
        }.onAppear {
            print(scrapData.attachments)
        }
    }
}

struct Scraps: View {
    @EnvironmentObject var apiSettings: API
    @State var scrapbookUser: UserType? = nil
    @State var posts: [PostType] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("Scraps")
                    .font(.title)
                    .fontWeight(.bold)
            }.padding(.horizontal, 50)
            if scrapbookUser != nil {
                ScrollView {
                    VStack {
                        ForEach(posts, id: \.id) {post in
                            ScrapView(scrapData: post)
                        }
                    }
                }
            } else {
                Text("Loading scraps…")
            }
        }.task {
            guard let myUrl = URL(string: "https://scrapbook.hackclub.com/api/users") else {
                print("Error: the scrapbook api url doesn't seem to be valid")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: myUrl)
                let scrapbookUsers: [UserType] = try JSONDecoder().decode([UserType].self, from: data)
                print(scrapbookUsers[0])
                for user in scrapbookUsers {
                    if user.slackID == apiSettings.slackId {
                        scrapbookUser = user
                        print("user found: \(user)")
                        break
                    }
                }
                
                if scrapbookUser != nil {
                    print("username: \(scrapbookUser!.username)")
                    guard let myUrl2 = URL(string: "https://scrapbook.hackclub.com/api/users/\(scrapbookUser!.username!)") else {
                        print("Invalid scrapbook username/url")
                        return
                    }
                    
                    print("myURL2: \(myUrl2)")
                    let (data, _) = try await URLSession.shared.data(from: myUrl2)
                    print("data: \(String(data: data, encoding: .utf8))")
                    let posts = try JSONDecoder().decode(UserInfo.self, from: data).posts
                    self.posts = posts
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
