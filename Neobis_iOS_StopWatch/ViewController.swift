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

class ViewController: UIViewController {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet weak var timePickerView: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var switchSegmentedControl: UISegmentedControl!
    
    var currentFunctionality = Functionality.Timer
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func switchFuntionality(_ sender: Any) {
        if (currentFunctionality == Functionality.Timer) {
            currentFunctionality = Functionality.StopWatch
            timePickerView.isHidden = false
            print("This is StopWatch")
        } else {
            currentFunctionality = Functionality.Timer
            timePickerView.isHidden = true
            print("This is Timer")
        }
    }
    
}
