//
//  ViewController.swift
//  ProxSens
//
//  Created by Dawood Khan on 11/25/15.
//  Copyright © 2015 Dawood Khan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    func proximityChanged(notification: NSNotification) {
        let device = notification.object as? UIDevice
        if device?.proximityState == true {
            print("\(device) detected!")
            toggleTorch(on: true)
        } else {
            toggleTorch(on: false)
        }
    }
    
    
    func activateProximitySensor() {
        let device = UIDevice.currentDevice()
        device.proximityMonitoringEnabled = true
        if device.proximityMonitoringEnabled {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "proximityChanged:", name: "UIDeviceProximityStateDidChangeNotification", object: device)
            
        }
    }
    
    func toggleTorch(on on: Bool) {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .On
                } else {
                    device.torchMode = .Off
                }
                
                device.unlockForConfiguration()
            } catch { 
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activateProximitySensor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

