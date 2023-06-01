//
//  NotificationUtil.swift
//  ToDo
//
//  Created by Aguru, Ganesh (Contractor) on 11/05/23.
//

import Foundation
import UIKit
import UserNotifications

extension UIViewController {
    
    
    func scheduleNotification(task:String,desc:String,date:Date,priority:String,type:String){
        
        //create notification content
        let content = UNMutableNotificationContent()
        content.title = task
        content.sound = .default
        content.body = desc
       
//        content.body = """
//
//"Task: "\(task),
//\(desc)
//"priority:\(priority), and it is \(type)"
//"""
        
    
        //create trigger
        
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        
        //create and register request
        
        let request = UNNotificationRequest(identifier: "todo", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
    
}
