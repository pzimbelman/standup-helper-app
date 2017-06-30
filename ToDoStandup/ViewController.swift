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
    var todayTasks: [Task] = []
    var yesterdayTasks: [Task] = []
    
    let taskStore = TaskStore()
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayTasks = taskStore.getTasksForToday()
        yesterdayTasks = taskStore.getTasksCompletedYesterday()
        
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
        todayTasks = taskStore.getTasksForToday()
        tableView.reloadData()
    }
    
    // number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return todayTasks.count
        } else {
            return yesterdayTasks.count
        }
    }
    
    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let task = taskForIndex(index: indexPath)
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        if indexPath.section == 0 && task.completedAt != nil {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: task.title!)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.textLabel?.attributedText = attributeString
        } else {
            if let title = task.title {
                cell.textLabel?.text = title
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var buttons = [UITableViewRowAction]()
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let task = self.taskForIndex(index: index)
            self.taskStore.deleteTask(task: task)
            self.todayTasks = self.taskStore.getTasksForToday()
            self.yesterdayTasks = self.taskStore.getTasksCompletedYesterday()
            tableView.deleteRows(at: [index as IndexPath], with: UITableViewRowAnimation.automatic)
        }
        delete.backgroundColor = .red
        buttons.append(delete)
        
        let finish = UITableViewRowAction(style: .normal, title: "Finish") { action, index in
            let task = self.taskForIndex(index: index)
            self.taskStore.finishTask(task: task)
            self.todayTasks = self.taskStore.getTasksForToday()
            self.yesterdayTasks = self.taskStore.getTasksCompletedYesterday()
            tableView.reloadData()
        }
        finish.backgroundColor = .green
        let task = taskForIndex(index: indexPath)
        if  task.completedAt == nil {
            buttons.append(finish)
        }
        
        return buttons
    }
    
    func taskForIndex(index: IndexPath) -> Task {
        if index.section == 0 {
            return todayTasks[index.row]
        } else {
            return yesterdayTasks[index.row]
        }
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Today"
        } else {
            return "Yesterday"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if taskStore.getTasksCompletedYesterday().count > 0 {
            return 2
        }
        return 1
    }
    
    func showAddView() {
        let addTaskViewController = AddTaskViewController()
        self.navigationController?.pushViewController(addTaskViewController, animated: true)
    }
}
