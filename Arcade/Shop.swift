// Shop.swift
// Arcade
//
// Created by Justin Huang on 7/14/24.

import Foundation
import SwiftUI

let scriptStart = "<script id=\"__NEXT_DATA__\" type=\"application/json\">"
let scriptEnd = "</script>"

struct ShopItemList: View {
    let item: AvailableItem
    let curHours: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(item.costHours > curHours ? .hcRed : .hcDark)
                .opacity(item.stock == 0 ? 0.25 : 1)
            HStack {
                VStack {
                    HStack {
                        Text("\(item.name)")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                        Spacer()
                    }
                    HStack {
                        Text("\(item.costHours) 🎟️")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                        Spacer()
                    }
                }
                Spacer()
                AsyncImage(url: URL(string: item.imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            }
            .padding()
        }
    }
}

struct ShopItemGrid: View {
    let item: AvailableItem
    let curHours: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(item.costHours > curHours ? .hcRed : .hcDark)
                .opacity(item.stock == 0 ? 0.25 : 1)
            VStack {
                AsyncImage(url: URL(string: item.imageURL)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 128, height: 128)
                
                Spacer()
                
                Text("\(item.name)")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                Text("\(item.costHours) 🎟️")
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
            }
        }
    }
}

struct Shop: View {
    @EnvironmentObject var apiSettings: API
    @State var shopItem: ShopItem?

    func getHTML(for url: String) async throws -> String {
        guard let myURL = URL(string: url) else {
            print("Error: \(url) doesn't seem to be a valid url")
            return ""
        }
        let dataReq = try await URLSession.shared.data(from: myURL)
        let myHTMLString = String(data: dataReq.0, encoding: .utf8)!
        // let myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
        // print("HTML: \(myHTMLString)")
        return myHTMLString
    }
    
    @State var shopViewModeGrid: Bool = true

    var body: some View {
        NavigationStack {
            VStack {
                if shopItem != nil {
                    VStack {
                        Text("Your current balance is \(shopItem!.props.pageProps.hoursBalance) 🎟️")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .padding(.top, 40)
                            .padding(.bottom, 20)
                        Toggle("Grid Mode", systemImage: "squareshape.split.3x3", isOn: $shopViewModeGrid)
                            .padding(.horizontal, 50)
                        Spacer()
                        ScrollView {
                            if !shopViewModeGrid {
                                LazyVStack(alignment: .leading) {
                                    ForEach(shopItem!.props.pageProps.availableItems.sorted(by: { $0.costHours < $1.costHours }), id: \.id) { item in
                                        NavigationLink {
                                            ShopItemDetail(item: item)
                                        } label: {
                                            ShopItemList(item: item, curHours: shopItem!.props.pageProps.hoursBalance)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                }
                                .padding(.horizontal, 50)
                            }
                            else {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                    ForEach(shopItem!.props.pageProps.availableItems.sorted(by: { $0.costHours < $1.costHours }), id: \.id) { item in
                                        NavigationLink {
                                            ShopItemDetail(item: item)
                                        } label: {
                                            ShopItemGrid(item: item, curHours: shopItem!.props.pageProps.hoursBalance)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                }.padding(.horizontal, 50)
                        }
                        }
                    }
                } else {
                    Text("Shop not loaded")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(.dark)
            .background(.hc)
        }
        .task {
            if shopItem == nil {
                do {
                    let html = try await getHTML(for: apiSettings.shopURL)
                    // print("html: \(html)")
                    let range: Range<String.Index> = html.range(of: scriptStart)!
                    let startIndex = html.distance(from: html.startIndex, to: range.lowerBound) + scriptStart.count
                    let endRange = html[html.index(html.startIndex, offsetBy: startIndex)...].range(of: scriptEnd)!
                    let endIndex = html.distance(from: html.startIndex, to: endRange.lowerBound)
                    let jsonSubstring = html[html.index(html.startIndex, offsetBy: startIndex)..<html.index(html.startIndex, offsetBy: endIndex)]
                    print("jsonSubstring: \(jsonSubstring)")
                    let shopItem: ShopItem = try JSONDecoder().decode(ShopItem.self, from: jsonSubstring.data(using: .utf8)!)
                    self.shopItem = shopItem
                    print("hoursBalance: \(shopItem.props.pageProps.hoursBalance)")
                } catch {
                    print("error getting html: \(error)")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
        .background(.hc)
    }
}

//#Preview {
//    struct Preview: View {
//        @State var shopUrl: String = "https://hackclub.com/arcade/[YOUR_ID]/shop/"
//        @StateObject var apiSettings = API()
//
//        var body: some View {
//            Shop()
//                .onAppear {
//                    apiSettings.shopURL = shopUrl
//                }
//                .environmentObject(apiSettings)
//        }
//    }
//    return Preview()
//}
