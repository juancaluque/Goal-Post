//
//  CreateGoalVC.swift
//  Goal-Post
//
//  Created by Juan Luque on 1/24/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    // OUTLETS
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var nextBtnPressed: UIButton!
    
    // VARIABLES
    var goalType: GoalType = .shortTerm
    
    // @IBACTIONS
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelected()
        longTermBtn.setDeselected()
        
    }
    @IBAction func longTermBtnPressed(_ sender: Any) {
        
        goalType = .longTerm
        longTermBtn.setSelected()
        shortTermBtn.setDeselected()
    }
    @IBAction func nextBtnPressed(_ sender: Any) {
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtnPressed.bindToKeyBoard()
        shortTermBtn.setSelected()
        longTermBtn.setDeselected()
    }


}
