//
//  CreateGoalVC.swift
//  Goal-Post
//
//  Created by Juan Luque on 1/24/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit


class CreateGoalVC: UIViewController, UITextViewDelegate {

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
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(identifier: "FinishGoalVC") as? FinishGoalVC else { return }
            finishGoalVC.initaData(description: goalTextView.text!, type: goalType)
            presentingViewController?.secondaryPresentDetail(finishGoalVC)
        } 
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTextView.delegate = self
        nextBtnPressed.bindToKeyBoard()
        shortTermBtn.setSelected()
        longTermBtn.setDeselected()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
