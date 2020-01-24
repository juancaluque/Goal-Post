//
//  GoalsVC.swift
//  Goal-Post
//
//  Created by Juan Luque on 1/23/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController{

    // OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    // @IBACTIONS
    @IBAction func addGoalPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(identifier: "CreateGoalVC") as? CreateGoalVC else { return }
        
        presentDetail(createGoalVC)
    }

    // LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        
        cell.configureCell(description: "Eat salad twice a week", type: .shortTerm, goalProgressAmount: 2)
        return cell
    }
    
    
    
}
