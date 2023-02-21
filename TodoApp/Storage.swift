//
//  Storage.swift
//  TodoApp
//
//  Created by gurzu on 21/12/2022.
//

import Foundation

class Storage {
    
    static let shared = Storage()
    private let defaults = UserDefaults.standard
    
    private init() {
        
    }
     
    func save(value: [TaskData], key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch let error {
            print("Error encoding: \(error)")
        }
    }
    
    func load(key: String) -> [TaskData] {
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                let tasks = try JSONDecoder().decode([TaskData].self, from: data)
                return tasks
            }
        } catch let error {
            print("Error decoding: \(error)")
            return [TaskData]()
        }
        return [TaskData]()
    }
    
    func delete(key: String, at index: Int) {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                var deleteTasks = try JSONDecoder().decode([TaskData].self, from: data)
                deleteTasks.remove(at: index)
                let data = try JSONEncoder().encode(deleteTasks)
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                print(error)
            }
        }
    }
}
