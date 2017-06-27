//
//  ViewController.swift
//  ToDoStandup
//
//  Created by Peter Zimbelman on 6/4/17.
//  Copyright © 2017 Peter Zimbelman. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UITableViewController  {
    
    // Data model: These strings will be the data for the table view cells
    var tasks: [Task] = []
    let taskStore = TaskStore()
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = taskStore.getAllRemainingTasks()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Tasks"
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(ViewController.showAddView))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tasks = taskStore.getAllRemainingTasks()
        tableView.reloadData()
    }
    
    // number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        if let title = self.tasks[indexPath.row].title {
          cell.textLabel?.text = title
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let task = self.tasks[index.row]
            self.taskStore.deleteTask(task: task)
            self.tasks = self.taskStore.getAllRemainingTasks()
            tableView.deleteRows(at: [index as IndexPath], with: UITableViewRowAnimation.automatic)
        }
        delete.backgroundColor = .red
        
        let finish = UITableViewRowAction(style: .normal, title: "Finish") { action, index in
            let task = self.tasks[index.row]
            self.taskStore.finishTask(task: task)
            self.tasks = self.taskStore.getAllRemainingTasks()
            tableView.reloadData()
        }
        finish.backgroundColor = .green
        
        return [finish, delete]
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "To Do"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func showAddView() {
        let addTaskViewController = AddTaskViewController()
        self.navigationController?.pushViewController(addTaskViewController, animated: true)
    }
}
