//
//  ViewController.swift
//  Neobis_iOS_StopWatch
//
//  Created by Alisher on 19.10.2023.
//

import UIKit


class TimerViewController: UIViewController {
    enum State {
        case timer, stopWatch
    }
    enum TimerStatus {
        case started, paused, stopped
    }
    
    @IBOutlet weak var timerImageView: UIImageView!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timePickerView: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var switchFunctionalitiesSegmentedControl: UISegmentedControl!
    
    var currentFunctionality = State.timer // Текущий функционал: Таймер или секундомер
    var currentStatus = TimerStatus.stopped // Текущий статус таймер: Запущено, в паузе или на стопе

    var timer = Timer()
    var executedTime = DateComponents() // Количество времени работы функционала
    
    var startedTime = Date() // Дата и время начала записи времени (Таймер)
    var givenTime = TimeInterval(0) // Заданное время (Секундомер)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if currentStatus != .started {
            startedTime = Calendar.current.date(byAdding: executedTime, to: Date()) ?? Date()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
            currentStatus = .started
            colorButtons()
            
            if currentFunctionality == .stopWatch {
                timePickerView.isHidden = true
            }
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if currentStatus == .started {
            currentStatus = .paused
            executedTime = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: (startedTime))
            timer.invalidate()
            colorButtons()
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        executedTime = DateComponents()
        timerLabel.text = String.toTimeString(0, 0, 0)
        currentStatus = .stopped
        colorButtons()
        
        if currentFunctionality == .stopWatch {
            timePickerView.isHidden = false
        }
    }
    
    @objc func UpdateTime() {
        let userCalendar = Calendar.current
        let currentTime = Date()
        let timeLeft = userCalendar.dateComponents([.hour, .minute, .second]
                                                   , from: (currentFunctionality == .timer ? startedTime : currentTime)
                                                   , to: currentFunctionality == .timer ? currentTime : startedTime + givenTime)
        // Display Countdown
        timerLabel.text = String.toTimeString(timeLeft.hour ?? 0, timeLeft.minute ?? 0, timeLeft.second ?? 0)
        
        if currentFunctionality == .stopWatch && timeLeft.hour == 0 && timeLeft.minute == 0 && timeLeft.second == 0 {
            stopButtonTapped(stopButton)
        }
    }
    
    @IBAction func switchFuntionality(_ sender: Any) {
        if (currentFunctionality == State.timer) {
            stopButtonTapped(stopButton) // Можно ли так?
            currentFunctionality = State.stopWatch
            timePickerView.isHidden = false
            timerImageView.image = UIImage(systemName: "stopwatch")
        } else {
            stopButtonTapped(stopButton)
            currentFunctionality = State.timer
            timePickerView.isHidden = true
            timerImageView.image = UIImage(systemName: "timer")
        }
    }
    
    func colorButtons() {
        playButton.changeButtonStyle(to: .normal)
        pauseButton.changeButtonStyle(to: .normal)
        
        switch currentStatus {
        case .started:
            playButton.changeButtonStyle(to: .clicked)
        case .paused:
            pauseButton.changeButtonStyle(to: .clicked)
        case .stopped:
            break
        }
    }
}


enum ButtonStyle {
    case clicked, normal
}


extension TimerViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 100
        } else {
            return 60
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hour = Int(pickerView.selectedRow(inComponent: 0))
        let minute = Int(pickerView.selectedRow(inComponent: 1))
        let second = Int(pickerView.selectedRow(inComponent: 2))
        
        timerLabel.text = String.toTimeString(hour, minute, second)
        givenTime = TimeInterval(hour * 3600 + minute * 60 + second)
    }
}

extension String {
    static func toTimeString(_ hour: Int, _ minute: Int, _ second: Int) -> String {
        return "\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(String(format: "%02d", second))"
    }
}

extension UIButton {
    func changeButtonStyle(to buttonStyle: ButtonStyle) {
        let customColor = UIColor.init(red: 105/255, green: 189/255, blue: 228/255, alpha: 1)
        
        self.backgroundColor = buttonStyle == .clicked ? customColor : .black
        self.tintColor = buttonStyle == .clicked ? .black : customColor
    }
}
