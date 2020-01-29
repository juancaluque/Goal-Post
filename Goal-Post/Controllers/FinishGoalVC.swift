//
//  FinishGoalVC.swift
//  Goal-Post
//
//  Created by Juan Luque on 1/27/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit
import CoreData

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
        if pointsTextField.text != "" && pointsTextField.text != "0" {
            save { (success) in
                if success {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
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
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("Saved data successfully!")
            completion(true)
        } catch {
            debugPrint("Could not save data: \(error.localizedDescription)")
            completion(false)
        }
    }
}
