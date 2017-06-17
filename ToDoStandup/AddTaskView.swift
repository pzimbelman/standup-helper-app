//
//  AddTaskView.swift
//  ToDoStandup
//
//  Created by Peter Zimbelman on 6/17/17.
//  Copyright © 2017 Peter Zimbelman. All rights reserved.
//

import Foundation
import UIKit

class AddTaskView: UIView {
    let addButton = UIButton(type: UIButtonType.system)
    let nameField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        nameField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Save Task", for: .normal)
        
        nameField.borderStyle = .roundedRect
        nameField.layer.borderColor = UIColor.black.cgColor
        nameField.placeholder = "Task Name"
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"

        self.addSubview(addButton)
        self.addSubview(nameField)
        self.addSubview(label3)
        let views = ["addButton": addButton, "nameField": nameField] as [String : Any]
        
        var allConstraints = [NSLayoutConstraint]()
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-100-[nameField(40)]-20-[addButton]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += NSLayoutConstraint.constraints(
            withVisualFormat: "H:[nameField(250)]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += [NSLayoutConstraint(item: addButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)]
        self.addConstraints(allConstraints)
        allConstraints += [NSLayoutConstraint(item: nameField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)]
        self.addConstraints(allConstraints)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
