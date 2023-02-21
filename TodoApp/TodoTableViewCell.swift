//
//  TodoTableViewCell.swift
//  TodoApp
//
//  Created by gurzu on 06/12/2022.
//

import UIKit

protocol TodoTableViewCellDelegate: AnyObject {
    func switchTapped(_ todoTableViewCell: TodoTableViewCell, cellTitle: String, state: Bool)
    func deleteButtonTapped(cellTitle: String)
}

class TodoTableViewCell: UITableViewCell {
    
    let identifier: String = "TodoCell"
    weak var delegate: TodoTableViewCellDelegate?
    
    @IBOutlet weak var todoTasksTitle: UILabel!
    @IBOutlet weak var taskCompletedSwitch: UISwitch!
    @IBOutlet weak var taskDeleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        todoTasksTitle.numberOfLines = 0
        
        taskCompletedSwitch.addTarget(self, action: #selector(tappedSwitch), for: .touchUpInside)
        
        taskDeleteButton.addTarget(self, action: #selector(tappedDelete), for: .touchUpInside)
    }
    
    @objc private func tappedSwitch() {
        self.delegate?.switchTapped(self, cellTitle: "\(todoTasksTitle.text ?? "")", state: taskCompletedSwitch.isOn)
    }
    
    @objc private func tappedDelete() {
        self.delegate?.deleteButtonTapped(cellTitle: "\(todoTasksTitle.text ?? "")")
    }
    
}
