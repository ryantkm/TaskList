//
//  DatePickerView.swift
//  TaskList
//
//  Created by Ryan Teo on 6/2/16.
//  Copyright © 2016 ryantkm. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate {
    func completePressed()
    func donePressed()
    func datePickerValueChanged(date: NSDate)
}

class DatePickerView: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerViewDelegate?
    
    @IBAction func completeBarButtonItemPressed(sender: UIBarButtonItem) {
        delegate?.completePressed()
    }
 
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        delegate?.donePressed()
    }

    @IBAction func datePickerChanged(sender: UIDatePicker) {
        delegate?.datePickerValueChanged(sender.date)
    }

}
