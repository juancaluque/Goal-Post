//
//  GoalCell.swift
//  Goal-Post
//
//  Created by Juan Luque on 1/23/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    // OUTLETS
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    // FUNC
    func configureCell(description: String, type: String, goalProgressAmount: Int) {
        self.goalDescriptionLbl.text = description
        self.goalTypeLbl.text = type
        self.goalProgressLbl.text = String(describing: goalProgressAmount)
        
        
    }
    
    

}
