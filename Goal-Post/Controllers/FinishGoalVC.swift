//
//  FinishGoalVC.swift
//  Goal-Post
//
//  Created by Juan Luque on 1/27/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    // OUTLETS
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    // VARIABLES
    var goalDescription: String!
    var goalType: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyBoard()
        pointsTextField.delegate = self

    }
    
    // @IBACTIONS
    @IBAction func createGoalBtnPressed(_ sender: Any) {
        // Pass data
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    // FUNC
    func initaData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pointsTextField.text = ""
    }

}
