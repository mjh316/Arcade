//
//  ArcadeStats.swift
//  Arcade
//
//  Created by Justin Huang on 7/9/24.
//

import Foundation

struct ArcadeStats: Decodable {
    let ok: Bool
    let data: StatData
    
    struct StatData: Decodable {
        let sessions: Int
        let total: Int
    }
}
