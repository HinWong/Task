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
    var fetchResultsController: NSFetchedResultsController<Task>
    
    //MARK:- Source of truth
//    var tasks: [Task] = {
//
//        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
//        return (try?CoreDataStack.context.fetch(fetchRequest)) ?? []
//    }()
    
    init() {
        let request:NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "due", ascending: true)]
        let resultsController: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        fetchResultsController = resultsController
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("cannot perform fetch \(error.localizedDescription) \(#function)")
        }
    }
    
    //MARK: - CRUD
    
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
    
    func toggleIsComplete(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    private func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        }
        catch {
            print("There was an error saving the data! \(#function) \(error.localizedDescription)")
        }
    }
}
