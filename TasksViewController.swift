//
//  TasksViewController.swift
//  TaskList
//
//  Created by Ryan Teo on 13/1/16.
//  Copyright © 2016 ryantkm. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var baseArray: [[TaskList]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task1 = TaskList(title: "design logo", dueDate: NSDate(), completed: false, favorite: true, repeated: nil, reminderDate: nil)
        
        let task2 = TaskList(title: "learn ios", dueDate: NSDate(), completed: false, favorite: false, repeated: nil, reminderDate: nil)
        
        let task3 = TaskList(title: "watch drama", dueDate: NSDate(), completed: false, favorite: false, repeated: nil, reminderDate: nil)
        
        baseArray = [[task1, task2, task3], []]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardDidHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editBarButtonTapped(sender: UIBarButtonItem) {
        if sender.title == "Edit" {
            if tableView.editing != true {
                tableView.setEditing(true, animated: true)
                sender.title = "Done"
            }
        }
        else if sender.title == "Done" {
            if tableView.editing {
                tableView.setEditing(false, animated: true)
                sender.title = "Edit"
            }
            else {
                let addTasksTableViewCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! AddTasksTableViewCell
                if addTasksTableViewCell.addTaskTextField != "" {
                    print("add new task")
                }
                else {
                    print("error")
                }
            }
        }
    }
    
    //MARK:  - Keyboard Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.title = "Done"
    }
    
    func keyboardWillHide(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.title = "Edit"
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 1 {
            return true
        }
        else {
            return false
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            tableView.beginUpdates()
            baseArray[indexPath.section - 1].removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
            
        }
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let currentTask = baseArray[0][sourceIndexPath.row]
        baseArray[0].removeAtIndex(sourceIndexPath.row)
        baseArray[0].insert(currentTask, atIndex: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: AddTasksTableViewCell = tableView.dequeueReusableCellWithIdentifier("AddTasksCell") as! AddTasksTableViewCell
            cell.backgroundColor = UIColor(red: 110/255, green: 30/255, blue: 240/255, alpha: 0.8)
            return cell
        }
        
        else if indexPath.section == 1 || indexPath.section == 2 {
            let cell: TasksTableViewCell = tableView.dequeueReusableCellWithIdentifier("TasksCell") as! TasksTableViewCell
            let currentTasks = baseArray[indexPath.section - 1][indexPath.row]
            cell.titleLabel.text = currentTasks.title
            
            let dateStringFormatter = NSDateFormatter()
            dateStringFormatter.dateStyle = NSDateFormatterStyle.FullStyle
            
            if let date = currentTasks.dueDate {
                //let dateString = dateStringFormatter.stringFromDate(date)
                cell.dueDateLabel.text = dateStringFormatter.stringFromDate(date)
            }
            
            if indexPath.section == 1 {
                cell.completedButton.backgroundColor = UIColor.redColor()
            }
            else {
                cell.completedButton.backgroundColor = UIColor.greenColor()
            }
            
            if currentTasks.favorite {
                cell.favoriteButton.backgroundColor = UIColor.blueColor()
            }
            else {
                cell.favoriteButton.backgroundColor = UIColor.orangeColor()
            }
            
            cell.backgroundColor = UIColor(red: 160/255, green: 40/255, blue: 100/255, alpha: 0.8)
            return cell
        }
            
        else {
            return UITableViewCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return baseArray[0].count
        } else if section == 2 {
            return baseArray[1].count
        } else {
            return 0
        }
    }
}
