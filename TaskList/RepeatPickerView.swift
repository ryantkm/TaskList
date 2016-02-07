//
//  RepeatPickerView.swift
//  TaskList
//
//  Created by Ryan Teo on 7/2/16.
//  Copyright © 2016 ryantkm. All rights reserved.
//

import UIKit

protocol RepeatPickerViewDelegate {
    func remove()
    func done()
    func pickerViewDidSelect(type: RepeatType)
}

class RepeatPickerView: UIView {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var delegate: RepeatPickerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    @IBAction func removeBarButtonItemPressed(sender: UIBarButtonItem) {
        delegate?.remove()
    }
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        delegate?.done()
    }
}

extension RepeatPickerView: UIPickerViewDataSource {
    
    // how many columns in the picker view
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
}

extension RepeatPickerView: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0: return "Everyday"
        case 1: return "Every Week"
        case 2: return "Every Month"
        default: return "Every Year"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let repeatValue = RepeatType(rawValue: row)!
        delegate?.pickerViewDidSelect(repeatValue)
    }
}