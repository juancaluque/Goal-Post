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
    @IBOutlet weak var goalCompletionView: UIView!
    
    // FUNC
    func configureCell(goal: Goal) {
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletionValue {
            goalCompletionView.isHidden = false
        } else {
            goalCompletionView.isHidden = true
        }
        
    }
    
    

}
