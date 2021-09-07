//
//  Stats.swift
//  VRC Team
//
//  Created by Raghav Punnam on 8/9/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import Foundation


//MARK: - Teams Information
struct TeamStats: Decodable {
    let result: [TeamInfo]
    let size: Int
    let status: Int
}

struct TeamInfo: Decodable, Hashable {
    let number: String
    let team_name: String
    let organisation: String
    let program: String
    let grade: String
    let city: String
    let region: String
    let country: String
}



//MARK: - Event Information
struct SeasonStats: Decodable {
    let result: [SeasonInfo]
    let size: Int
    let status: Int
}

struct SeasonInfo: Decodable {
    let team: String
    let season: String
    let vrating_rank: Int
    let vrating: Double
}

struct EventInfo {
    let eventDetails: [EventDetailsInfo?]
    let eventPerformance: [EventPerformanceInfo?]
}

struct EventDetailsStats: Decodable {
    var result: [EventDetailsInfo]
    let size: Int
    let status: Int
}

struct EventDetailsInfo: Decodable {
    let sku: String
    let name: String
    let loc_region: String
    let end: String
}

struct EventPerformanceStats: Decodable {
    var result: [EventPerformanceInfo]
    let size: Int
    let status: Int
}

struct EventPerformanceInfo: Decodable {
    let sku: String
    let rank: Int
    let wins: Int
    let losses: Int
    let ties: Int
    let wp: Int
    let ap: Int
    let sp: Int
    let trsp: Int
    let max_score: Int
    let opr: Double
    let dpr: Double
    let ccwm: Double
}

struct MatchInfoStats: Decodable {
    var result: [MatchInfo]
    let size: Int
    let status: Int
}

struct MatchInfo: Decodable {
    let red1: String
    let red2: String
    let blue1: String
    let blue2: String
    let redscore: Int
    let bluescore: Int
    let round: Int
    let matchnum: Int
}
