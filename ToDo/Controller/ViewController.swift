//
//  ViewController.swift
//  ToDo
//
//  Created by Aguru, Ganesh (Contractor) on 05/05/23.
//

import UIKit

class ViewController: UIViewController {

    var isAuthorized = false
    
    @IBOutlet weak var prioritySC: UISegmentedControl!
    @IBOutlet weak var typeSC: UISegmentedControl!
    @IBOutlet weak var dateP: UIDatePicker!
    @IBOutlet weak var descF: UITextView!
    @IBOutlet weak var taskF: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkNotificationPermission()
        
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    
   
    @IBAction func addTaskClick(_ sender: UIButton) {
        
        //typeSC.isHidden.self = true 
        //sent the data to the database
        let task = taskF.text ?? ""
        let desc = descF.text ?? ""
        let date = dateP.date
    
        let typeIndex = typeSC.selectedSegmentIndex
        let type = typeSC.titleForSegment(at: typeIndex)
        
        let priorityIndex = prioritySC.selectedSegmentIndex
        let priority = prioritySC.titleForSegment(at: priorityIndex)

        ToDoUtility.instance.addTask(task: task, desc: desc, date: date, type: type ?? "", priority: priority ?? "")
        
        scheduleNotification(task: task, desc: desc, date: date, priority: priority ?? "", type: type ?? "")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "toTasks") as! ToDoVC
        self.navigationController?.pushViewController(vc, animated: true)
        
       // typeSC.isHidden = false
        
    }
    
    
    
    func checkNotificationPermission(){
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus{
            
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
                    if success{
                        self.isAuthorized = true
                    }
                    else{
                        self.isAuthorized = false
                    }
                }
                break
                
            case .denied:
                self.isAuthorized = false
            case .authorized:
                self.isAuthorized = true
            
            default:
                break
            }
        }
    }
    
    
}


extension ViewController: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    

    
}






