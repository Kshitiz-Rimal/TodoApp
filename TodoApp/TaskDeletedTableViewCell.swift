//
//  TaskDeletedTableViewCell.swift
//  TodoApp
//
//  Created by gurzu on 20/12/2022.
//

import UIKit

class TaskDeletedTableViewCell: UITableViewCell {
    
    static let identifier: String = "TaskDeletedTableViewCell"

    @IBOutlet weak var taskDeletedTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskDeletedTitle.numberOfLines = 0
    }
}
