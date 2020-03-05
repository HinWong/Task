//
//  TaskController.swift
//  Task
//
//  Created by Hin Wong on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    //MARK:- shared instance
    static let sharedInstance = TaskController()
    
    //MARK:- Source of truth
    var tasks: [Task] = []
    
    init() {
        tasks = fetchTasks()
    }
    
    var mockTasks:[Task] = {
        
        let task1 = Task(name: "wake up", notes: "wake up", due: Date(), isComplete:false)
        let task2 = Task(name: "sleep", notes: "sleep", due: Date(), isComplete:false)
        
        return [task1, task2]
    }()
    
    //MARK: - CRUD
    
    func fetchTasks() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return (try?CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func add(name:String, notes:String?, due:Date?) {
        Task(name: name, notes:notes , due: due)
        saveToPersistentStore()
    }
    
    func update(task:Task, name:String, notes:String?, due:Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task:Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        }
        catch {
            print("There was an error saving the data! \(#function) \(error.localizedDescription)")
        }
    }
    
}
