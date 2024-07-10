//
//  ArcadeHistory.swift
//  Arcade
//
//  Created by Justin Huang on 7/10/24.
//

import Foundation

struct ArcadeHistory: Codable {
    let ok: Bool
    let data: [HistoryData]?
    
    struct HistoryData: Codable {
        let createdAt: String //  "2024-06-23T05:09:04.105Z",
        let time: Int
        let elapsed: Int
        let goal: String
        let ended: Bool
        let work: String
    }
}
