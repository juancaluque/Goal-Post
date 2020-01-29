//
//  GoalsVC.swift
//  Goal-Post
//
//  Created by Juan Luque on 1/23/20.
//  Copyright © 2020 Juan Luque. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController{

    // OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removedView: UIView!
    
    
    // @IBACTIONS
    @IBAction func addGoalPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(identifier: "CreateGoalVC") as? CreateGoalVC else { return }
        
        presentDetail(createGoalVC)
    }
    @IBAction func undoRemoved(_ sender: Any) {
        self.removedView.isHidden = true

        loadDeletedGoal { (success) in
            if success {
                print("Loaded deleted goal succesful")
            }
        }
        
        fetchCoreDataObjects()
        self.tableView.reloadData()
    }
    
    // VARIABLES
    var goals: [Goal] = []
    var deletedGoals: [Goal] = []
    var deletedGoalDescription: String?
    var deletedGoalType: String?
    var deletedGoalCompletionValue: Int32?

    // LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        removedView.isHidden = true
        fetchCoreDataObjects()
        tableView.reloadData()
    }
}


extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            self.removedView.isHidden = false
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UIContextualAction(style: .normal, title: "ADD 1") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        addAction.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.6509803922, blue: 0.137254902, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        return UISwipeActionsConfiguration(actions: [deleteAction, addAction])
    }
    
}

extension GoalsVC {
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Saved progress success!")
        } catch {
            debugPrint("Could not add progrss: \(error.localizedDescription)")
        }
    }
    func fetch(completion: (_ finish:Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    func fetchCoreDataObjects() {
        fetch { (success) in
            if success {
                if goals.count >= 1 {
                    self.tableView.isHidden = false
                } else {
                    self.tableView.isHidden = true
                }
            }
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        saveDeletedGoal(atIndexPath: indexPath)
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let deletedGoal = goals[indexPath.row]
        self.deletedGoals.append(deletedGoal)
        
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("Removed goal successfully!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    func saveDeletedGoal(atIndexPath indexPath: IndexPath) {
        
        self.deletedGoalDescription = goals[indexPath.row].goalDescription
        self.deletedGoalType = goals[indexPath.row].goalType
        self.deletedGoalCompletionValue = goals[indexPath.row].goalCompletionValue
    }
    
    func loadDeletedGoal(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let deletedGoal = Goal(context: managedContext)
        
        deletedGoal.goalDescription = deletedGoalDescription
        deletedGoal.goalType = deletedGoalType
        deletedGoal.goalProgress = Int32(0)
        deletedGoal.goalCompletionValue = Int32(deletedGoalCompletionValue!)
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not load deleted Goal: \(error.localizedDescription)")
            completion(false)
        }
    }
}


