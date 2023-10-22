//
//  ViewController.swift
//  Neobis_iOS_StopWatch
//
//  Created by Alisher on 19.10.2023.
//

import UIKit

enum Functionality {
    case Timer, StopWatch
}

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet weak var timePickerView: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var switchSegmentedControl: UISegmentedControl!
    
    var currentFunctionality = Functionality.Timer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
    }

    @IBAction func switchFuntionality(_ sender: Any) {
        if (currentFunctionality == Functionality.Timer) {
            currentFunctionality = Functionality.StopWatch
            timePickerView.isHidden = false
        } else {
            currentFunctionality = Functionality.Timer
            timePickerView.isHidden = true
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 100
        } else {
            return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hour = String(format: "%02d", Int(pickerView.selectedRow(inComponent: 0)))
        let minute = String(format: "%02d", Int(pickerView.selectedRow(inComponent: 1)))
        let second = String(format: "%02d", Int(pickerView.selectedRow(inComponent: 2)))
        
        timeLabel.text = "\(hour):\(minute):\(second)"
    }
}

