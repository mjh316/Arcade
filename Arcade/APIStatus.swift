//
//  APIStatus.swift
//  Arcade
//
//  Created by Justin Huang on 7/14/24.
//

import Foundation

struct APIStatus: Codable {
    let activeSessions: Int
    let airtableConnected: Bool
    let slackConnected: Bool
}
