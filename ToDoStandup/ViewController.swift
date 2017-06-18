//
//  ViewController.swift
//  ToDoStandup
//
//  Created by Peter Zimbelman on 6/4/17.
//  Copyright © 2017 Peter Zimbelman. All rights reserved.
//

import UIKit
import CoreData
import SWTableViewCell
class ViewController: UITableViewController  {
    
    // Data model: These strings will be the data for the table view cells
    var tasks: [Task] = []
    let taskStore = TaskStore()
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = taskStore.getAllTasks()
        
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
        tasks = taskStore.getAllTasks()
        tableView.reloadData()
    }
    
    // number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:SWTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! SWTableViewCell!
        
        // set the text from the data model
        if let title = self.tasks[indexPath.row].title {
          cell.textLabel?.text = title
        }
        cell.leftUtilityButtons = cellButtons() as! [Any]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let task = self.tasks[indexPath.row]
            taskStore.deleteTask(task: task)
            tasks = taskStore.getAllTasks()
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func showAddView() {
        let addTaskViewController = AddTaskViewController()
        self.navigationController?.pushViewController(addTaskViewController, animated: true)
    }
    
    func cellButtons() -> NSMutableArray {
        let buttons = NSMutableArray()
        buttons.sw_addUtilityButton(with: UIColor.init(colorLiteralRed: 0.07, green: 0.75, blue: 0.16, alpha: 1.0), icon: UIImage.init(imageLiteralResourceName: "check.png"))
        return buttons
    }
}
