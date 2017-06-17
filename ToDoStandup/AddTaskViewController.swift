//
//  AddTaskViewController.swift
//  ToDoStandup
//
//  Created by Peter Zimbelman on 6/17/17.
//  Copyright © 2017 Peter Zimbelman. All rights reserved.
//

import UIKit
class AddTaskViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "New Task"
        let addView = AddTaskView()
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
    }
}
