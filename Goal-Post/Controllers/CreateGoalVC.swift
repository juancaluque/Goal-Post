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
    
    // @IBACTIONS
    @IBAction func shortTermBtnPressed(_ sender: Any) {
    }
    @IBAction func longTermBtnPressed(_ sender: Any) {
    }
    @IBAction func nextBtnPressed(_ sender: Any) {
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
