//
//  API.swift
//  Arcade
//
//  Created by Justin Huang on 7/8/24.
//

import Foundation

struct API {
    private let apiKey: String
    private let slackId: String
    
    func getSession() async throws -> ArcadeSession {
        guard let url = URL(string: "https://hackhour.hackclub.com/api/session/\(slackId)") else  {fatalError("Missing URL in getSession()")}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let sessionResult = try JSONDecoder().decode(ArcadeSession.self, from: data)
        return sessionResult
    }
}
