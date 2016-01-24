//
//  AddTasksTableViewCell.swift
//  TaskList
//
//  Created by Ryan Teo on 13/1/16.
//  Copyright © 2016 ryantkm. All rights reserved.
//

import UIKit

class AddTasksTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addTaskTextField: UITextField!
    
    var favorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        favoriteButton.backgroundColor = UIColor.orangeColor()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoriteButtonTapped(sender: UIButton) {
        if addTaskTextField.isFirstResponder() {
            favorite = !favorite
            if favorite {
                favoriteButton.backgroundColor = UIColor.blueColor()
            }
            else {
                favoriteButton.backgroundColor = UIColor.orangeColor()
            }
        }
    }
}
