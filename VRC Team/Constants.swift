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
    
    // Team Section Names
    static let teamMainInfoGroupNames = ["Name", "Organization", "Program", "Grade", "City", "Region", "Country"]
    
    
    static let segueFromTeamsListToTeam = "IndividualTeamStatsSegue"
}
