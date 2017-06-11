//
//  MWAlerts.swift
//  MobeWash
//
//  Created by Chad Lohrli on 5/7/17.
//
//

import Foundation
import UIKit
import ReachabilitySwift

class MWAlerts {
    
    static let reachability = Reachability()!
    
    // MARK -- Alerts
    
    class func alertMessage(message:String, sender: UIViewController){
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        sender.present(alert, animated: true, completion: nil)
        
    }
    
    
    class func alertConnection(sender: UIViewController){
        
        let alertController = UIAlertController (title: "Check Internet Connectivity", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        sender.present(alertController, animated: true, completion: nil)
        
    }
    

    // TODO -- Reachability
    
//    class func startNotifier(sender: UIViewController){
//
//        
//        //declare this inside of viewWillAppear
//        
//        NotificationCenter.default.addObserver(sender, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
//        do{
//            try reachability.startNotifier()
//        }catch{
//            print("could not start reachability notifier")
//        }
//        
//
//        
//    }
//    
//    @objc func reachabilityChanged(note: NSNotification) {
//        
//        let reachability = note.object as! Reachability
//        
//        if reachability.isReachable {
//            if reachability.isReachableViaWiFi {
//                print("Reachable via WiFi")
//            } else {
//                print("Reachable via Cellular")
//            }
//        } else {
//            print("Network not reachable")
//            
//        }
//    }
//    
//    class func stopNotifier(sender: UIViewController){
//        reachability.stopNotifier()
//        NotificationCenter.default.removeObserver(sender, name: ReachabilityChangedNotification,
//                                                            object: reachability)
//    }


    
    
    
}
