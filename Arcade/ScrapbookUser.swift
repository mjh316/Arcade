//
//  ScrapbookUser.swift
//  Arcade
//
//  Created by Justin Huang on 7/27/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scrapbookUser = try? JSONDecoder().decode(ScrapbookUser.self, from: jsonData)

import Foundation

// MARK: - ScrapbookUserElement
struct ScrapbookUser: Codable {
    let id: String
    let slackID, email, emailVerified: String?
    let username: String
    let streakCount, maxStreaks: Int?
    let displayStreak, streaksToggledOff: Bool?
    let customDomain: String?
    let cssURL: String?
    let website: String?
    let github: String?
    let image: String?
    let fullSlackMember: Bool?
    let avatar: String
    let webring: [String]
    let newMember: Bool
    let timezoneOffset: Int?
    let timezone: String?
    let pronouns: Pronouns?
    let customAudioURL: String?
    let lastUsernameUpdatedTime, webhookURL: String?
}

enum Pronouns: String, Codable {
    case heHim = "he/him"
    case heHimHis = "he/him/his"
    case theyThemTheirs = "they/them/theirs"
}
