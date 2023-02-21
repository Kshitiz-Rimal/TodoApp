//
//  TaskData.swift
//  TodoApp
//
//  Created by gurzu on 06/12/2022.
//

import Foundation

struct TaskData: Codable {
    var taskTitle: String
    var taskIsCompleted: Bool
    var taskIsDeleted: Bool
}
