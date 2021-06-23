//
//  DataBaseHelper.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/23/21.
//

import Foundation
import UIKit
import CoreData

struct DatabaseHandler {
    
    static let shared: DatabaseHandler = DatabaseHandler()
    
    
    
    //MARK: - Insert values in database

    func createEnqury(newEnquiry: Enqries, handler:(_ status: Bool) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: AppCells.userEntity.getName(), in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        user.setValue(newEnquiry.email, forKeyPath: "email")
        user.setValue(newEnquiry.description, forKeyPath: "descriptioninfo")
        user.setValue(newEnquiry.subscription, forKeyPath: "subscription")
        user.setValue(newEnquiry.visaTypes, forKey: "visatype")
        
        do{
            try managedContext.save()
            handler(true)
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            handler(false)
            
        }
        
    }
    //MARK: - fetch data from database

    func retrieveData(handler: (_ userRecords: [NSManagedObject]) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: AppCells.userEntity.getName())
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let userRecords = result as? [NSManagedObject] {
                handler(userRecords)
            } else{
                handler([])
                
            }
            for data in result as! [NSManagedObject] {
                print(data)
            }
            
        } catch {
            handler([])
            
            print("Failed")
        }
        
    }
    
    
}
