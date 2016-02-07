//
//  TasksViewController.swift
//  TaskList
//
//  Created by Ryan Teo on 13/1/16.
//  Copyright © 2016 ryantkm. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var baseArray: [[TaskList]] = []
    
    var selectedTaskIndexPath: NSIndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task1 = TaskList(title: "design logo", dueDate: NSDate(), completed: false, favorite: true, repeated: nil, reminderDate: nil)
        
        let task2 = TaskList(title: "learn ios", dueDate: NSDate(), completed: false, favorite: false, repeated: nil, reminderDate: nil)
        
        let task3 = TaskList(title: "watch drama", dueDate: NSDate(), completed: false, favorite: false, repeated: nil, reminderDate: nil)
        
        baseArray = [[task1, task2, task3], []]
        
        tableView.backgroundColor = UIColor.clearColor()
        
        let gestureRecogniser = UILongPressGestureRecognizer(target: self, action: "longPressRecognised:")
        gestureRecogniser.minimumPressDuration = 1.0
        tableView.addGestureRecognizer(gestureRecogniser)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardDidHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    func longPressRecognised(gestureRecogniser: UILongPressGestureRecognizer) {
        if !tableView.editing {
            tableView.editing = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tasksToSingleTaskSegue" {
            let indexPath = sender as! NSIndexPath
            let selectedTask = baseArray[indexPath.section - 1][indexPath.row]
            let oneTaskViewController = segue.destinationViewController as! OneTaskViewController
            oneTaskViewController.task = selectedTask
            oneTaskViewController.mainVC = self
        }
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
                if addTasksTableViewCell.addTaskTextField.text != "" {
                    let newTask = TaskList(title: addTasksTableViewCell.addTaskTextField.text!, dueDate: NSDate(), completed: false, favorite: addTasksTableViewCell.favorite, repeated: nil, reminderDate: nil)
                    baseArray[0].append(newTask)
                    tableView.reloadData()
                    addTasksTableViewCell.addTaskTextField.text = ""
                    addTasksTableViewCell.addTaskTextField.resignFirstResponder()
                }
                else {
                    let errorAlert = UIAlertController(title: "Empty Task", message: "Please enter a title before adding a task.", preferredStyle: UIAlertControllerStyle.Alert)
                    errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    presentViewController(errorAlert, animated: true, completion: nil)
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
}

extension TasksViewController: UITableViewDataSource {
    
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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: AddTasksTableViewCell = tableView.dequeueReusableCellWithIdentifier("AddTasksCell") as! AddTasksTableViewCell
            cell.backgroundColor = UIColor(red: 110/255, green: 30/255, blue: 240/255, alpha: 0.8)
            cell.favoriteButton.backgroundColor = UIColor.orangeColor()
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
            
            //            cell.backgroundColor = UIColor(red: 160/255, green: 40/255, blue: 100/255, alpha: 0.8)
            
            cell.indexPath = indexPath
            cell.delegate = self
            
            return cell
        }
            
        else {
            return UITableViewCell()
        }
    }

    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 1 {
            return true
        }
        else {
            return false
        }
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let currentTask = baseArray[0][sourceIndexPath.row]
        baseArray[0].removeAtIndex(sourceIndexPath.row)
        baseArray[0].insert(currentTask, atIndex: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 && baseArray[1].count > 0 {
            return "\(baseArray[1].count) completed items"
        }
        return ""
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            tableView.beginUpdates()
            baseArray[indexPath.section - 1].removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
            
        }
    }
}

extension TasksViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section != 0 {
            performSegueWithIdentifier("tasksToSingleTaskSegue", sender: indexPath)
            selectedTaskIndexPath = indexPath
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
    
    // customising the length of the separator
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    // adjusting the height of header
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 && baseArray[1].count > 0 {
            return 100
        }
        return 0
    }
    
    // setting height of the footer after each section
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if tableView.editing {
            return UITableViewCellEditingStyle.None
        }
        return UITableViewCellEditingStyle.Delete
    }
    
    // remove indent during editing mode
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}

extension TasksViewController: TasksTableViewCellDelegate {

    func completeTask(indexPath: NSIndexPath) {
        print("Task completed")
        var selectedTask = baseArray[indexPath.section - 1][indexPath.row]
        selectedTask.completed = !selectedTask.completed
        if indexPath.section == 1 {
            baseArray[1].append(selectedTask)
        }
        else {
            baseArray[0].append(selectedTask)
        }
        baseArray[indexPath.section - 1].removeAtIndex(indexPath.row)
        
        tableView.reloadData()
    }
    
    func favoriteTask(indexPath: NSIndexPath) {
        print("Task favorited")
        var selectedTask = baseArray[indexPath.section - 1][indexPath.row]
        selectedTask.favorite = !selectedTask.favorite
        baseArray[indexPath.section - 1][indexPath.row] = selectedTask
        
        tableView.reloadData()
    }
}
