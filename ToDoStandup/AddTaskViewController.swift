//
//  AddTaskViewController.swift
//  ToDoStandup
//
//  Created by Peter Zimbelman on 6/17/17.
//  Copyright © 2017 Peter Zimbelman. All rights reserved.
//

import UIKit
class AddTaskViewController: UIViewController  {
    
    let addView = AddTaskView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "New Task"
        addView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addView)
        

        let verticalContraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[addView]|",
            options: [],
            metrics: nil,
            views: ["addView": addView])
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[addView]|",
            options: [],
            metrics: nil,
            views: ["addView": addView])
        self.view.addConstraints(horizontalConstraints)
        self.view.addConstraints(verticalContraints)
        
        addView.addButton.addTarget(self, action: #selector(AddTaskViewController.handleSaveClick), for: .touchUpInside)
    }
    
    func handleSaveClick() {
        let titleContent = addView.nameField.text
        let trimmedContent = titleContent?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if(trimmedContent == "") {
            let alert = UIAlertController(title: "Error", message: "Title must be set", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
