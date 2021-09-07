//
//  Constants.swift
//  VRC Team
//
//  Created by Raghav Punnam on 8/9/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import Foundation

struct Constants {
    // Team List Table View Constants
    static let teamSearchCellIdentifier = "TeamsListTableViewCell"
    static let teamsCellNibName = "TeamsListCell"
    
    // Team Information Table View Constants
    static let teamInfoCellIndendifier = "TeamInfoTableViewCell"
    static let teamInfoCellNibName = "TeamInfoCell"
    static let numberOfTableSections = 2
    
    
    // Season Information Table View Constants
    static let seasonPerformanceTableSections = 2
    static let numberOfSeasonRatings = 2
    static let ratingIdentifiers = ["vRating Rank", "vRating"]
    static let ratingCellNibName = "RatingCell"
    static let ratingCellIdentifier = "RatingTableViewCell"
    
    static let eventInformationCellNibName = "EventInformationCell"
    static let eventInformationCellIdentifier = "EventInformationTableViewCell"
    
    static let matchInformationCellNibName = "MatchInfoCell"
    static let matchInformationCellIdentifier = "MatchInfoTableViewCell"
    
    // Team Section Names
    static let teamMainInfoGroupNames = ["Name", "Organization", "Program", "Grade", "City", "Region", "Country"]
    
    
    static let segueFromTeamsListToTeam = "IndividualTeamStatsSegue"
    static let segueFromTeamToSeasonPerformance = "TeamToSeasonPerformanceSegue"
    static let segueFromSeasonPerformanceToMatches = "EventsToMatchesSegue"
    static let segueFromMatchesToTeam = "MatchesToTeamSegue"
}
