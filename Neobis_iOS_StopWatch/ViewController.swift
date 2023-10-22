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
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var switchSegmentedControl: UISegmentedControl!
    
    var currentFunctionality = Functionality.Timer
    
    var timer: Timer!
    
    var startedTime: Date!
    var timeOnRunning: DateComponents!
    
    var isTimerRunning = false
    var isTimerPaused = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if !isTimerRunning {
            startedTime = Date()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
            isTimerRunning = true
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if !isTimerPaused && isTimerRunning {
            timeOnRunning = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: (startedTime))
            
            timer.invalidate()
            isTimerPaused = true
        } else if isTimerPaused {
            startedTime = Calendar.current.date(byAdding: timeOnRunning, to: Date())
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
            isTimerPaused = false
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        isTimerRunning = false
        isTimerPaused = false
        timeOnRunning = nil
        timerLabel.text = "00:00:00"
    }
    
    
    
    @objc func UpdateTime() {
        let userCalendar = Calendar.current
        let currentTime = Date()
        
        // Change the seconds to days, hours, minutes and seconds
        let timeLeft = userCalendar.dateComponents([.day, .hour, .minute, .second], from: (startedTime), to: currentTime)
        
        // Display Countdown
        timerLabel.text = "\(String(format: "%02d",timeLeft.hour!)):\(String(format: "%02d",timeLeft.minute!)):\(String(format: "%02d",timeLeft.second!))"
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
        
        timerLabel.text = "\(hour):\(minute):\(second)"
    }
    
}

