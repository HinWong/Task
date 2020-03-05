//
//  Task+Convenience.swift
//  Task
//
//  Created by Hin Wong on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    @discardableResult
    convenience init (name:String, notes:String?, due:Date?, context:NSManagedObjectContext = CoreDataStack.context, isComplete:Bool = false) {
        
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = isComplete
    }
}
