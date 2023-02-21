//
//  TaskCompletedViewController.swift
//  TodoApp
//
//  Created by gurzu on 02/12/2022.
//

import UIKit

class TaskCompletedViewController: UIViewController {
    
    @IBOutlet weak var taskCompletedTableView: UITableView!
    
    var completedTasks: [TaskData] = Storage.shared.load(key: "completedTaskLabel")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.title = "Completed Task"
        self.tabBarController?.navigationItem.title = "Task Completed"
        self.parent?.navigationItem.rightBarButtonItem = nil
        
        taskCompletedTableView.delegate = self
        taskCompletedTableView.dataSource = self
        
        taskCompletedTableView.register(UINib(nibName: TaskCompletedTableViewCell.identifier, bundle: nil),
                                        forCellReuseIdentifier: TaskCompletedTableViewCell.identifier)
    }
    
    func updateValue() {
        completedTasks = Storage.shared.load(key: "completedTaskLabel")
    }
}

extension TaskCompletedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateValue()
        return completedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell=taskCompletedTableView.dequeueReusableCell(withIdentifier: TaskCompletedTableViewCell.identifier,
                                                                 for: indexPath) as? TaskCompletedTableViewCell {
            cell.taskCompletedTitle.text = completedTasks[indexPath.row].taskTitle
            
            return cell
        }
        return UITableViewCell()
    }
}

extension TaskCompletedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Completed Tasks"
    }
}
