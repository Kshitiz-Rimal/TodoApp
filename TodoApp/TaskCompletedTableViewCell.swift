//
//  TaskCompletedTableViewCell.swift
//  TodoApp
//
//  Created by gurzu on 12/12/2022.
//

import UIKit

class TaskCompletedTableViewCell: UITableViewCell {
    
    static let identifier: String = "TaskCompletedTableViewCell"
    
    @IBOutlet weak var taskCompletedTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskCompletedTitle.numberOfLines = 0
    }
}
