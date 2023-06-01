//
//  RemainderVC.swift
//  ToDo
//
//  Created by Aguru, Ganesh (Contractor) on 08/05/23.
//

import UIKit

class RemainderVC: UIViewController {

   
    
    @IBOutlet weak var setL: UILabel!
    @IBOutlet weak var descL: UILabel!
    @IBOutlet weak var startTimeL: UILabel!
    
    @IBOutlet weak var priorityL: UILabel!
    
    @IBOutlet weak var typeL: UILabel!
    
    var remainder : ToDo?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setL.text = remainder?.task
        descL.text = remainder?.desc
        startTimeL.text = remainder?.date?.formatted()
        priorityL.text = remainder?.priority
        typeL.text = remainder?.type
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
