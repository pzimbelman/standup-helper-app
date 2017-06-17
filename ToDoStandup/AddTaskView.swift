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
    let addButton = UIButton()
    let nameField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        nameField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.titleLabel?.text = "TEST"
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"

        self.addSubview(addButton)
        self.addSubview(nameField)
        self.addSubview(label3)
        let views = ["addButton": addButton, "nameField": nameField, "label": label3] as [String : Any]
        
        var allConstraints = [NSLayoutConstraint]()
        let verticalContraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[label(30)]-10-|",
            options: [],
            metrics: nil,
            views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[label(100)]",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += verticalContraints
        allConstraints += horizontalConstraints
        self.addConstraints(allConstraints)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
