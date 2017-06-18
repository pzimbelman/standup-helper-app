//
//  TaskStore.swift
//  ToDoStandup
//
//  Created by Peter Zimbelman on 6/17/17.
//  Copyright © 2017 Peter Zimbelman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TaskStore {
    
    let appDelegate =
        UIApplication.shared.delegate as! AppDelegate
    func getAllTasks() -> [Task] {
        let managedContext =
            appDelegate.persistentContainer.viewContext

        var tasks = [Task]()
        do {
            tasks = try managedContext.fetch(Task.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return tasks
    }
    
    func deleteTask(task: Task) {
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        managedContext.delete(task)
        appDelegate.saveContext()
    }
}
