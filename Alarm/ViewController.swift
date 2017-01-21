//
//  ViewController.swift
//  Alarm
//
//  Created by Alex Mang on 1/20/17.
//  Copyright © 2017 Alex Mang. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet var moving: UILabel!
    
    var oldData : CMAcceleration?
    
    var timer: Timer!
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        manager.startAccelerometerUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)

    }

    func update() {
        print("updating")
        if let accelerometerData = manager.accelerometerData {
            let data = accelerometerData.acceleration
            if (isDifferent(data: data)) {
                moving.text = "Moving!!"
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

    
    
}

        
