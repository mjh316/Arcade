//
//  ArcadeSession.swift
//  Arcade
//
//  Created by Justin Huang on 7/8/24.
//

import Foundation

struct ArcadeSession: Decodable {
    let ok: Bool
    let data: SessionData
    
    struct SessionData: Identifiable, Decodable {
        let id: String
        let createdAt: String // format: 2024-06-23T02:49:17.900Z
        let time: Int
        let elapsed: Int
        let remaining: Int
        let endTime: String // format 2024-06-23T03:08:00.000Z
        let goal: String
        let paused: Bool
        let completed: Bool
        let messageTs: String
    }
}
