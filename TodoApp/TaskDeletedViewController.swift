//
//  TaskDeletedViewController.swift
//  TodoApp
//
//  Created by gurzu on 02/12/2022.
//

import UIKit

class TaskDeletedViewController: UIViewController {
    
    @IBOutlet weak var taskDeletedTableView: UITableView!
    
    var deletedTasks: [TaskData] = Storage.shared.load(key: "deletedTaskLabel")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "Deleted Task"
        self.tabBarController?.navigationItem.title = "Task Deleted"
        self.parent?.navigationItem.rightBarButtonItem = nil
        
        taskDeletedTableView.delegate = self
        taskDeletedTableView.dataSource = self
        
        taskDeletedTableView.register(UINib(nibName: TaskDeletedTableViewCell.identifier, bundle: nil),
                                        forCellReuseIdentifier: TaskDeletedTableViewCell.identifier)
    }
    
    func updateValue() {
        deletedTasks = Storage.shared.load(key: "deletedTaskLabel")
    }

}

extension TaskDeletedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateValue()
        return deletedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        deletedTasks = Storage.shared.load(key: "deletedTaskLabel")
        if let cell=taskDeletedTableView.dequeueReusableCell(withIdentifier: TaskDeletedTableViewCell.identifier,
                                                                 for: indexPath) as? TaskDeletedTableViewCell {
            cell.taskDeletedTitle.text = deletedTasks[indexPath.row].taskTitle
            
            return cell
        }
        return UITableViewCell()
    }
}

extension TaskDeletedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Deleted Tasks"
    }
}
