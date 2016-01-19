//
//  DataModel.swift
//  TaskList
//
//  Created by Ryan Teo on 14/1/16.
//  Copyright © 2016 ryantkm. All rights reserved.
//

import Foundation

enum RepeatType: Int {
case daily = 0
case weekly = 1
case monthly = 2
case yearly = 3
}

struct TaskList {
    
    var title: String
    var dueDate: NSDate?
    var completed: Bool
    var favorite: Bool
    
    var repeated: RepeatType?
    var reminderDate: NSDate?
    
}