//
//  ToDoUtility.swift
//  ToDo
//
//  Created by Aguru, Ganesh (Contractor) on 05/05/23.
//

import Foundation
import UIKit

struct ToDoUtility {
    
    
    static var instance = ToDoUtility()
    
    
    //this is for managing and manipulating the database
    let dbContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){
        
    }
    
    //add the task function
    func addTask(task:String,desc:String,date:Date,type:String,priority:String){
        
        let todo = ToDo(context: dbContext)
        // assigning to  db class
        todo.date=date
        todo.task=task
        todo.desc=desc
        todo.type=type
        todo.priority=priority
        
        do{
            //saving
            try dbContext.save()
            print("Task added successfully")
        }catch{
            print("error adding task")
        }
        
    }
    
    
    
    //get all all the todo data
    
    func getAllTodoData() ->[ToDo]{
        
        let toDoList = ToDo.fetchRequest()
        do{
             let result = try dbContext.fetch(toDoList)
            return result
        }catch{
            return []
        }
        
    }
    
    
    //delete the task func
    func deleteTask(todo:ToDo){
        
        dbContext.delete(todo)
        do{
            try dbContext.save()
        }catch{
            
        }
        
    }
    
    
    //get the task based on official or personal
    func getTaskByType(type:String ) -> [ToDo]{

        let typeReq = ToDo.fetchRequest()
        typeReq.predicate =  NSPredicate(format: "type == %@", type)
        do{
           let result = try dbContext.fetch(typeReq)
            return result
        }catch{
            return []
        }
    }
    
    //get the task based on high, medium, low priorities
    
    func getTaskByPriority(priority:String) -> [ToDo]{
        let priorReq = ToDo.fetchRequest()
        
        priorReq.predicate = NSPredicate(format: "priority == %@", priority)
        do{
           let result = try dbContext.fetch(priorReq)
            return result
        }catch{
            return []
        }
    }
    
    
    
//    func getTaskEditable(toEdit:ToDo){
//
//        toEdit.desc = "moidifi"
//
//        
//    }
    
    
    
    
}
