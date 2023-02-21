//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by gurzu on 02/12/2022.
//

import UIKit

class TodoListViewController: UIViewController {
        
    @IBOutlet weak var todoTableView: UITableView!
    
    var todoTasks: [TaskData] = Storage.shared.load(key: "todoTaskLabel")
    var completedTasks: [TaskData] = Storage.shared.load(key: "completedTaskLabel")
    var deletedTasks: [TaskData] = Storage.shared.load(key: "deletedTaskLabel")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Todo List"
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                                         style: .plain,
                                                                         target: self,
                                                                         action: #selector(addTapped))
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        todoTableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil),
                               forCellReuseIdentifier: TodoTableViewCell().identifier)
    }
    
    @objc private func addTapped() {
        let popUpView = AddItemPopupViewController()
        popUpView.appear(sender: self)
        popUpView.delegate = self
    }
    
    func updateAllValue() {
        todoTasks = Storage.shared.load(key: "todoTaskLabel")
        completedTasks = Storage.shared.load(key: "completedTaskLabel")
        deletedTasks = Storage.shared.load(key: "deletedTaskLabel")
    }
}

extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        print("Todo", todoTasks)
        if todoTasks[indexPath.row].taskIsCompleted == false && todoTasks[indexPath.row].taskIsDeleted == false {
            if let cell = todoTableView.dequeueReusableCell(withIdentifier: TodoTableViewCell().identifier,
                                                            for: indexPath) as? TodoTableViewCell {
                cell.todoTasksTitle.text = todoTasks[indexPath.row].taskTitle
                
                cell.delegate = self
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Todo Tasks"
    }
}

extension TodoListViewController: RefreshTodoPage {
    func refreshPage() {
        updateAllValue()
        todoTableView?.reloadData()
    }
}

extension TodoListViewController: TodoTableViewCellDelegate {
    func switchTapped(_ todoTableViewCell: TodoTableViewCell, cellTitle: String, state: Bool) {
        let completedTaskPopUpView = TaskCompletedPopUpViewController()
        guard let currentIndex = todoTableView.indexPath(for: todoTableViewCell) else { return }
        completedTaskPopUpView.setup(cellIndex: currentIndex.row, cellTitle: todoTasks[currentIndex.row].taskTitle)
        completedTaskPopUpView.completedPopUpAppear(sender: self)
        completedTaskPopUpView.delegate = self
    }
    
    func deleteButtonTapped(cellTitle: String) {
        let alert = UIAlertController(
            title: "Are you sure you want to delete this task?",
            message: nil,
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(
            title: "Yes",
            style: .destructive,
            handler: { [self] _ in
                if let index = todoTasks.firstIndex(where: {$0.taskTitle == "\(cellTitle)"}) {
                    todoTasks[index].taskIsDeleted = true
                    deletedTasks.insert(todoTasks[index], at: 0)
                    Storage.shared.save(value: deletedTasks, key: "deletedTaskLabel")
                    Storage.shared.delete(key: "todoTaskLabel", at: index)
                    updateAllValue()
                }
                self.todoTableView?.reloadData()
            }
        )
        )
        alert.addAction(UIAlertAction(
            title: "No",
            style: .default
            )
        )
        present(alert, animated: true)
    }
}

extension TodoListViewController: TaskCompletedPopUpViewControllerDelegate {
    func onCancelButtonPressed(cellIndex: Int) {
        todoTasks[cellIndex].taskIsCompleted = true
//        todoTableView.cellForRow(at: )
    }
    
    func onDoneButtonPressed(cellTitle: String) {
        updateAllValue()
        print("Todotasks", todoTasks)
        if let index = todoTasks.firstIndex(where: {$0.taskTitle == "\(cellTitle)"}) {
            todoTasks[index].taskIsCompleted = true
            completedTasks.insert(todoTasks[index], at: 0)
            Storage.shared.save(value: completedTasks, key: "completedTaskLabel")
            Storage.shared.delete(key: "todoTaskLabel", at: index)
            updateAllValue()
        }
        self.todoTableView?.reloadData()
    }
}
