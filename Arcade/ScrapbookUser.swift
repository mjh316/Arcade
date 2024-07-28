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

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scrapbookUser = try? JSONDecoder().decode(ScrapbookUser.self, from: jsonData)

import Foundation

struct UserInfo: Codable {
    var profile: UserType?
    var posts: [PostType]
    var webring: [String]
}


struct PostType: Codable {
    var id: String
    var user: UserType?
    var timestamp: TimeInterval
    var slackUrl: String?
    var postedAt: String
    var text: String
    var attachments: [String]
    var mux: [String]
    var reactions: [ReactionType]
}

struct ReactionType: Codable {
    var name: String
    var usersReacted: [String]
    var url: String?
    var char: String?
}

struct UserType: Codable {
    var id: String?
    var slackID: String?
    var email: String?
    var emailVerified: String?
    var username: String?
    var streakCount: Int?
    var maxStreaks: Int?
    var displayStreak: Bool?
    var streaksToggledOff: Bool?
    var customDomain: String?
    var cssURL: String?
    var website: String?
    var github: String?
    var image: String?
    var fullSlackMember: Bool?
    var avatar: String?
    var webring: [String]?
    var newMember: Bool?
    var timezoneOffset: Int?
    var timezone: String?
    var pronouns: String?
    var customAudioURL: String?
    var lastUsernameUpdatedTime: String?
    var webhookURL: String?
}

