//
//  TeamsListCell.swift
//  VRC Team
//
//  Created by Raghav Punnam on 8/10/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import UIKit

class TeamsListCell: UITableViewCell {

    @IBOutlet weak var teamNumberLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
