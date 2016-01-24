//
//  TasksTableViewCell.swift
//  TaskList
//
//  Created by Ryan Teo on 13/1/16.
//  Copyright © 2016 ryantkm. All rights reserved.
//

import UIKit

protocol TasksTableViewCellDelegate {
    func completeTask(indexPath: NSIndexPath)
    func favoriteTask(indexPath: NSIndexPath)
}

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    
    var indexPath: NSIndexPath!
    
    var delegate: TasksTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoriteButtonTapped(sender: UIButton) {
        delegate?.favoriteTask(indexPath)
    }
    
    @IBAction func completedButtonTapped(sender: UIButton) {
        delegate?.completeTask(indexPath)
    }
    
    // hidding some elements when in edit mode
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        if editing {
            dueDateLabel.hidden = true
            favoriteButton.hidden = true
            completedButton.hidden = true
        }
        else {
            dueDateLabel.hidden = false
            favoriteButton.hidden = false
            completedButton.hidden = false
        }
    }
}
