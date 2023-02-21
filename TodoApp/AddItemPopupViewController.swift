//
//  AddItemPopupViewController.swift
//  TodoApp
//
//  Created by gurzu on 07/12/2022.
//

import UIKit

protocol RefreshTodoPage {
    func refreshPage()
}

class AddItemPopupViewController: UIViewController {
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var addTaskPopupTitle: UILabel!
    @IBOutlet weak var popupTextArea: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var delegate: RefreshTodoPage?
    
    var saveTodoTask: [TaskData] = Storage.shared.load(key: "todoTaskLabel")
    
    init() {
        super.init(nibName: "AddItemPopupViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoPopupViewComponents()
    }
    
    func todoPopupViewComponents() {
        self.view.backgroundColor  = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
        addTaskPopupTitle.text = "Add to your todo list"
        popupTextArea.placeholder = "Enter Your Text Here"
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancleButtonPressed), for: .touchUpInside)
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: true) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.2, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    @objc private func addButtonPressed() {
        if let str = popupTextArea.text {
            if !str.isEmpty && !str.trimmingCharacters(in: .whitespaces).isEmpty {
                let todoTitle = TaskData(taskTitle: str, taskIsCompleted: false, taskIsDeleted: false)
                saveTodoTask.insert(todoTitle, at: 0)
                Storage.shared.save(value: saveTodoTask, key: "todoTaskLabel")
            }
            self.delegate?.refreshPage()
        }
        hide()
    }
        
    @objc private func cancleButtonPressed() {
        hide()
    }
}
