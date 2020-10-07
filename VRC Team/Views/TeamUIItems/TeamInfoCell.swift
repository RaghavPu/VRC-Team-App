//
//  TeamInfoCell.swift
//  VRC Team
//
//  Created by Raghav Punnam on 8/10/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import UIKit

class TeamInfoCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
