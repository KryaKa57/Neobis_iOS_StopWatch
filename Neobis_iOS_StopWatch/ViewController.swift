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

    @IBOutlet weak var timerImageView: UIImageView!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var timePickerView: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var switchSegmentedControl: UISegmentedControl!
    
    var currentFunctionality = Functionality.Timer // Текущий функционал: Таймер или секундомер
    
    var timer: Timer!
    
    var startedTime: Date! // Дата и время начала записи времени
    var timeOnRunning: DateComponents! // Количество времени работы функционала
    
    var isTimerRunning = false // Работает ли таймер
    var isTimerPaused = false // На паузе ли таймер
    
    var givenTime: TimeInterval! = TimeInterval(0) // Заданное время секундомера
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if !isTimerRunning {
            startedTime = isTimerPaused ? Calendar.current.date(byAdding: timeOnRunning, to: Date()) : Date()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
            isTimerRunning = true
            isTimerPaused = false
            
            colorButtons()
        }
        
        if currentFunctionality == .StopWatch {
            timePickerView.isHidden = true
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if isTimerRunning && !isTimerPaused{
            timeOnRunning = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: (startedTime))
            timer.invalidate()
            isTimerPaused = true
            isTimerRunning = false
            
            colorButtons()
        }
        
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        isTimerRunning = false
        isTimerPaused = false
        timeOnRunning = nil
        timerLabel.text = "00:00:00"
        colorButtons()
        
        if currentFunctionality == .StopWatch {
            timePickerView.isHidden = false
        }
    }
    
    @objc func UpdateTime() {
        let userCalendar = Calendar.current
        let currentTime = Date()
        
        let timeLeft = userCalendar.dateComponents([.hour, .minute, .second]
                                                   , from: (currentFunctionality == .Timer ? startedTime : currentTime)
                                                   , to: currentFunctionality == .Timer ? currentTime : startedTime + givenTime)
        
        // Display Countdown
        timerLabel.text = "\(String(format: "%02d",timeLeft.hour!)):\(String(format: "%02d",timeLeft.minute!)):\(String(format: "%02d",timeLeft.second!))"
        
        if currentFunctionality == .StopWatch && timer != nil && timeLeft.hour == 0 && timeLeft.minute == 0 && timeLeft.second == 0 {
            stopButtonTapped(stopButton)
        }
    }
    
    @IBAction func switchFuntionality(_ sender: Any) {
        if (currentFunctionality == Functionality.Timer) {
            if isTimerRunning || isTimerPaused {
                stopButtonTapped(stopButton)
            }
            currentFunctionality = Functionality.StopWatch
            timePickerView.isHidden = false
            timerImageView.image = UIImage(systemName: "stopwatch")
        } else {
            if isTimerRunning || isTimerPaused {
                stopButtonTapped(stopButton)
            }
            currentFunctionality = Functionality.Timer
            timePickerView.isHidden = true
            timerImageView.image = UIImage(systemName: "timer")
        }
    }
    
    func colorButtons() {
        if isTimerRunning {
            playButton.backgroundColor = .white
            pauseButton.backgroundColor = .black
        } else if isTimerPaused {
            playButton.backgroundColor = .black
            pauseButton.backgroundColor = .white
        } else {
            playButton.backgroundColor = .black
            pauseButton.backgroundColor = .black
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
        let hour = Int(pickerView.selectedRow(inComponent: 0))
        let minute = Int(pickerView.selectedRow(inComponent: 1))
        let second = Int(pickerView.selectedRow(inComponent: 2))
        
        timerLabel.text = "\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(String(format: "%02d", second))"
        givenTime = TimeInterval(hour * 3600 + minute * 60 + second)
    }
    
}

