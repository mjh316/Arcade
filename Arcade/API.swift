//
//  API.swift
//  Arcade
//
//  Created by Justin Huang on 7/8/24.
//

import Foundation
import SwiftData

@Model
final class APIData {
    @Attribute(.unique) var apiKey: String
    var slackId: String
    var shopURL: String

    init(apiKey: String, slackId: String, shopURL: String) {
        self.apiKey = apiKey
        self.slackId = slackId
        self.shopURL = shopURL
    }
}

class API: ObservableObject {
    @Published var apiKey: String = ""
    @Published var slackId: String = ""
    @Published var shopURL: String = ""
    
    static func getStatusCheck() async throws -> APIStatus {
        guard let url = URL(string: "https://hackhour.hackclub.com/status") else {
            fatalError("Missing URL in getStatusCheck()")
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let statsResult = try JSONDecoder().decode(APIStatus.self, from: data)
        
        return statsResult
    }
    
    
    func getSession() async throws -> ArcadeSession {
        guard let url = URL(string: "https://hackhour.hackclub.com/api/session/\(slackId)") else  {fatalError("Missing URL in getSession()")}
        
        // https://stackoverflow.com/questions/58518474/passing-headers-to-url-with-swift-urlsession
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        
        let sessionResult = try JSONDecoder().decode(ArcadeSession.self, from: data)
        return sessionResult
    }
    
    func getStats() async throws -> ArcadeStats {
        guard let url = URL(string: "https://hackhour.hackclub.com/api/stats/\(slackId)") else {
            fatalError("Missing URL in getStats()")
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let statsResult = try JSONDecoder().decode(ArcadeStats.self, from: data)
        
        return statsResult
    }
    
    func getHistory() async throws -> ArcadeHistory {
        guard let url = URL(string: "https://hackhour.hackclub.com/api/history/\(slackId)") else {
            fatalError("Missing URL in getStats()")
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let statsResult = try JSONDecoder().decode(ArcadeHistory.self, from: data)
        
        return statsResult
    }
    
}
