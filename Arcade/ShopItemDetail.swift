//
//  ShopItemDetail.swift
//  Arcade
//
//  Created by Justin Huang on 7/14/24.
//

import Foundation
import SwiftUI

struct ShopItemDetail: View {
    let item: AvailableItem
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.hcDark)
                VStack {
                    HStack {
                        Text(item.fullName)
                            .fontWeight(.bold)
                            .font(.title)
                            .fontDesign(.rounded)
                        Spacer()
                    }
                    AsyncImage(url: URL(string: item.imageURL)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 280, maxHeight: 280)
                    HStack {
                        Text("\(item.costHours) 🎟️")
                            .fontWeight(.bold)
                            .font(.title2)
                            .fontDesign(.rounded)
                        Spacer()
                    }
                    .padding(.horizontal)
                    HStack {
                        Text(try! AttributedString(markdown: item.description ?? ""))
                            .fontDesign(.rounded)
                        Spacer()
                    }.padding(.horizontal)
                    HStack {
                        Text(try! AttributedString(markdown: item.fulfillmentDescription))
                            .fontDesign(.rounded)
                        Spacer()
                    }.padding(.horizontal)
                    HStack {
                        Text("You can order up to \(item.maxOrderQuantity) of these!")
                            .fontDesign(.rounded)
                        Spacer()
                    }.padding(.horizontal)
                    
                    
                    Spacer()
                    if item.stock == nil {
                        Text("There is no current stock limit for this item.")
                    } else {
                        Text("Stock left: \(item.stock!)")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundStyle(item.stock == 0 ? .red : .white)
                    }
                }.padding()
            }
            .padding()
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.hc)
    }
}


//#Preview {
//    ShopItemDetail()
//}
