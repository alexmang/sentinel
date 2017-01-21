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
    
    var player: AVAudioPlayer?
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
        player?.stop()


//        timer2.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        
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
                timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.alarm), userInfo: nil, repeats: false)
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
            //AudioServicesPlayAlertSound (systemSoundID)
            
            //Prepare the sound file name & extension
            
            let url = Bundle.main.url(forResource: "alarm", withExtension: "wav")!
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else {return}
                
                player.prepareToPlay()
                player.play()
            } catch let error {
                print("oh no")
            }
            
//            }
//            let alertSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "alarm", ofType: "wav")!)
//            
//            //Preparation to play
//            do {
//                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            }
//            catch {
//                print("uh oh")
//            }
//            do {
//                try AVAudioSession.sharedInstance().setActive(true)
//            }
//            catch {
//                print("uh oh")
//            }
//            
//            //Play audio
//            do {
//                print("here!")
//                let audioPlayer = try AVAudioPlayer(contentsOf: alertSound as URL)
//                print("going strong")
//                var ready = audioPlayer.prepareToPlay()
//                print(ready)
//                ready = audioPlayer.play()
//                print(ready)
//            }
//            catch {
//                print("uh oh")
//            }
//            if let view = volumeView.subviews.first as? UISlider
//            {
//                view.value = 0.7   // set b/w 0 t0 1.0
//            }
//            AudioServicesPlayAlertSound (systemSoundID)
        }
    }
    
    
    
}

        
