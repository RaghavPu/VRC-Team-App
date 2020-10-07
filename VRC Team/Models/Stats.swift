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
