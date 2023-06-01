//
//  ToDoVC.swift
//  ToDo
//
//  Created by Aguru, Ganesh (Contractor) on 05/05/23.
//

import UIKit

class ToDoVC: UIViewController {
    
    var todoList: [ToDo] = []

    @IBOutlet weak var typeSC: UISegmentedControl!
    @IBOutlet weak var priorityP: UIPickerView!
    
    @IBOutlet weak var tableTV: UITableView!
    
    let priorityList = ["All","High","Medium","Low"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ToDooos"
        tableTV.dataSource = self
        tableTV.delegate = self
        
        priorityP.dataSource = self
        priorityP.delegate = self
        
        //typeSC.isHidden = true
        
        priorityP.selectRow(1, inComponent: 0, animated: false)
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        todoList = ToDoUtility.instance.getAllTodoData()
        tableTV.reloadData()
    }
    
    
    
    @IBAction func typeClick(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
           todoList =  ToDoUtility.instance.getAllTodoData()
        case 1:
            todoList = ToDoUtility.instance.getTaskByType(type: "Personal")
        case 2:
            todoList = ToDoUtility.instance.getTaskByType(type: "Official")
        default:
            break
        }
        tableTV.reloadData()
    }
    
    
    
    
}




extension ToDoVC:UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //render the cell
        let cell = tableTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoCell
        //bind the data to the cell
        let todo = todoList[indexPath.row]
        
       
        
        cell.taskL.text = todo.task
        cell.descL.text = todo.desc
        cell.dateL.text = todo.date?.formatted()
       cell.typeL.text = todo.type
       cell.priorityL.text = todo.priority
//        print(cell)
        return cell
    }
}

extension ToDoVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
            let deleteAction = UIContextualAction.init(style: .destructive, title: "Delete") { _, _, _ in
            let toDoListDelete = self.todoList[indexPath.row]
            ToDoUtility.instance.deleteTask(todo: toDoListDelete)
            self.todoList.remove(at: indexPath.row)
            self.tableTV.reloadData()
                
        }
        
//        let editAction = UIContextualAction.init(style: .normal, title: "Edit") { _, _, _ in
//            let toDoEdit = self.todoList[indexPath.row]
//
//        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "viewRemainder", sender: self)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "viewRemainder") as? RemainderVC else {
            return
            
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        let passData = self.todoList[indexPath.row]
        vc.remainder = passData
      
    }
    
}



extension ToDoVC:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityList.count
    }
}

extension ToDoVC:UIPickerViewDelegate{
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return priorityList[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 20
//    }
//
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = priorityList[row]
        
        switch selected{
        case "High":
            todoList =  ToDoUtility.instance.getTaskByPriority(priority: "High")
        case "Medium":
            todoList = ToDoUtility.instance.getTaskByPriority(priority: "Medium")
            
        case "Low":
            todoList = ToDoUtility.instance.getTaskByPriority(priority: "Low")
            
        default:
            todoList = ToDoUtility.instance.getAllTodoData()
        }
        
        tableTV.reloadData()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let lbl = UILabel()
        lbl.text = priorityList[row]
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
        
    }
}


