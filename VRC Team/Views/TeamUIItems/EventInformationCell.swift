//
//  EventInformationCell.swift
//  VRC Team
//
//  Created by Raghav Punnam on 11/20/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import UIKit

class EventInformationCell: UITableViewCell {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventRegion: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var losses: UILabel!
    @IBOutlet weak var ties: UILabel!
    @IBOutlet weak var wp: UILabel!
    @IBOutlet weak var ap: UILabel!
    @IBOutlet weak var sp: UILabel!
    @IBOutlet weak var trsp: UILabel!
    @IBOutlet weak var maxScore: UILabel!
    @IBOutlet weak var opr: UILabel!
    @IBOutlet weak var dpr: UILabel!
    @IBOutlet weak var ccwm: UILabel!
    
    @IBOutlet weak var edgeView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setShadowWidgetBorder(view: edgeView, largeCornerCuts: true)
        setShadowWidgetBorder(view: view1, largeCornerCuts: false)
        setShadowWidgetBorder(view: view2, largeCornerCuts: false)
        setShadowWidgetBorder(view: view3, largeCornerCuts: false)
        setShadowWidgetBorder(view: view4, largeCornerCuts: false)
        setShadowWidgetBorder(view: view5, largeCornerCuts: false)
        
        let clearView = UIView()
        clearView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.selectedBackgroundView = clearView
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
    
    
    
}
