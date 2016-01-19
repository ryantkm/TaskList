//
//  TasksTableViewCell.swift
//  TaskList
//
//  Created by Ryan Teo on 13/1/16.
//  Copyright © 2016 ryantkm. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoriteButtonTapped(sender: UIButton) {
    }
    
    @IBAction func completedButtonTapped(sender: UIButton) {
    }
}
