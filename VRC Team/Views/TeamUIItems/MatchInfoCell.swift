//
//  MatchInfoCell.swift
//  VRC Team
//
//  Created by Raghav Punnam on 12/22/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import UIKit

protocol MatchCellDelegate: class{
    func selectTeam(tag: String)
}

class MatchInfoCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var roundAndMatch: UILabel!
    
    @IBOutlet weak var blueOne: UIButton!
    @IBOutlet weak var blueTwo: UIButton!
    @IBOutlet weak var redOne: UIButton!
    @IBOutlet weak var redTwo: UIButton!
    
    @IBOutlet weak var blueScore: UILabel!
    @IBOutlet weak var redScore: UILabel!
    
    weak var delegate: MatchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setShadowWidgetBorder(view: view, largeCornerCuts: true)
        setShadowWidgetBorder(view: blueView, largeCornerCuts: false)
        setShadowWidgetBorder(view: redView, largeCornerCuts: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setShadowWidgetBorder(view: UIView, largeCornerCuts: Bool) {
        view.layer.cornerRadius = largeCornerCuts ? 20 : 5
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = largeCornerCuts ? 0.1 : 0.05
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = largeCornerCuts ? 10 : 3;
    }
    
    
    @IBAction func blueOnePressed(_ sender: UIButton) {
        delegate?.selectTeam(tag: sender.titleLabel?.text ?? "")
    }
    
    @IBAction func blueTwoPressed(_ sender: UIButton) {
        delegate?.selectTeam(tag: sender.titleLabel?.text ?? "")
    }
    
    @IBAction func redOnePressed(_ sender: UIButton) {
        delegate?.selectTeam(tag: sender.titleLabel?.text ?? "")
    }
    
    @IBAction func redTwoPressed(_ sender: UIButton) {
        delegate?.selectTeam(tag: sender.titleLabel?.text ?? "")
    }
    
    
    
    
}
