//
//  ViewController.swift
//  Alarm
//
//  Created by Alex Mang on 1/20/17.
//  Copyright © 2017 Alex Mang. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation
import UserNotifications
import MediaPlayer


class ViewController: UIViewController {

    @IBOutlet var moving: UILabel!
    
    var oldData : CMAcceleration?
    
    var deactivated : Bool!
    
    var timer: Timer!
    var timer2: Timer!
    let manager = CMMotionManager()
    let systemSoundID: SystemSoundID = 1016
    let volumeView = MPVolumeView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    @IBAction func activateAlarm(_ sender: UIButton) {
        manager.startAccelerometerUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    
    
    @IBAction func deactivateAlarm(_ sender: UIButton) {
        deactivated = true
        
        manager.stopAccelerometerUpdates()
        moving.text = "Not Moving!"

        
        if timer != nil{
            timer.invalidate()
        }
        if timer2 != nil{
            timer2.invalidate()
        }
        
    }
    

    func update() {
        print("updating")
        if let accelerometerData = manager.accelerometerData {
            let data = accelerometerData.acceleration
            if (isDifferent(data: data)) {
                moving.text = "Moving!!"
                deactivated = false
                
                
                
                timer.invalidate()
                timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.alarm), userInfo: nil, repeats: true)
            } else {
                moving.text = "Not Moving!"
                
            }
            oldData = data
            print(accelerometerData.acceleration)
        }
    }
    
    func isDifferent(data: CMAcceleration) -> Bool {
        if(oldData == nil) {
            return false
        }
        
        let x_same = abs((oldData?.x)! - data.x) < 0.05
        let y_same = abs((oldData?.y)! - data.y) < 0.05
        let z_same = abs((oldData?.z)! - data.z) < 0.05
        return !(x_same && y_same && z_same)
    }

    func alarm () {
        if !deactivated {
//            if let view = volumeView.subviews.first as? UISlider
//            {
//                view.value = 0.7   // set b/w 0 t0 1.0
//            }
            AudioServicesPlayAlertSound (systemSoundID)
            
        }
    }
    
    
}

        
