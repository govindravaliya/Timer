//
//  ViewController.swift
//  Timer
//
//  Created by Govind Ravaliya on 5/18/18.
//  Copyright © 2018 Govindmac. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK:- OUTLETS
    
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    // MARK:- PROPERTIES
    
    var isTimerRuning : Bool = false
    var seconds : Int =  00
    var timer = Timer()
    
    
    // MARK:- VIEW LIFE CYCLE
    
    override func viewDidLoad()    {
        super.viewDidLoad()
        
        self.doSetupUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK:- UI SETUP
    
    
    func doSetupUI() {
        
        self.changeButtonState(.Reset)
        
    }
    
    
    // MARK:- OTHER FUNCTION
    
    
    /// Button click event handler.
    ///
    /// - Parameter state: Button State
    func changeButtonState(_ state : btnClick) {
        
        switch state {
        case .Start:
        
            btnStart.isEnabled = false
            btnStop.isEnabled = true
            btnReset.isEnabled = true
            self.startNewTimer()
            
            break
        case .Stop:
            
            btnStart.isEnabled = true
            btnStop.isEnabled = false
            btnReset.isEnabled = true
            self.stopTimer()
            
            break
        case .Reset:
            
            btnStart.isEnabled = true
            btnStop.isEnabled = false
            btnReset.isEnabled = true
            self.removeTimer()
       
            break
        }
        
    }
    
    
    /// Start New timer.
    func startNewTimer()  {
        // allock repeat timer for timeInterval of 1 second
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: (#selector(self.updateTimerValue)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    
    /// Stop Timer.
    func stopTimer()  {
        timer.invalidate()
    }
    
    
    /// Removae time and reser second.
    func removeTimer()  {
        seconds = 0
        timer.invalidate()
        self.convertToHoursMinuteSeconds(seconds)
    }
    
    
    /// Update Second value when timer run in loop.
    @objc func updateTimerValue() {
        seconds += 1     //This will increment(count down)the seconds.
        self.convertToHoursMinuteSeconds(seconds)
    }
    
    
    /// Convert Int value to Houe Hours Minute and Seconds.
    ///
    /// - Parameter second: total second (Int)
    func convertToHoursMinuteSeconds(_ second: Int){
        var num_seconds: Int = seconds
        let days: Int = num_seconds / (60 * 60 * 24)
        num_seconds -= days * (60 * 60 * 24)
        let hours: Int = num_seconds / (60 * 60)
        num_seconds -= hours * (60 * 60)
        let minutes: Int = num_seconds / 60
        num_seconds %= 60
        

        DispatchQueue.main.async {
            self.lblTimer.text = String(format: "%02d:%02d:%02d", hours,minutes,num_seconds)
        }
       // lblTimer.text = "\(hours):\(minutes):\(num_seconds)"
       // print("\(hours):\(minutes):\(num_seconds)")
    }

    
    
    // MARK:- BUTTON EVENTS
    
    
    /// Button Start click event.
    ///
    /// - Parameter sender: UIButton
    @IBAction func btnStart_Click(_ sender: Any) {
        
        self.changeButtonState(.Start)
    }
    
    
    /// Button Stop click event.
    ///
    /// - Parameter sender: UIButton
    @IBAction func btnStop_Click(_ sender: Any) {
        
        self.changeButtonState(.Stop)
    }
    
    
    /// Button Reset click event.
    ///
    /// - Parameter sender: UIButton
    @IBAction func btnReset_Click(_ sender: Any) {
        
        self.changeButtonState(.Reset)
    }
    
    
    // MARK:- API
    
    
    
    // MARK:- NAVIGATION
    
    
}


/// Enum for button click events.
///
/// - Start: for button start click.
/// - Stop: or button stop click.
/// - Reset: or button reset click.
enum btnClick : Int {
    case Start
    case Stop
    case Reset
}

