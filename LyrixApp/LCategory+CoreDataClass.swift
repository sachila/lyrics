//
//  LCategory+CoreDataClass.swift
//  LyrixApp
//
//  Created by sachila on 5/20/18.
//  Copyright © 2018 Infinity. All rights reserved.
//
//

import Foundation
import CoreData

@objc(LCategory)
public class LCategory: NSManagedObject {

    
    class func GetAllCategories(context: NSManagedObjectContext) -> [LCategory]{
        var data:[LCategory] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LCategory")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result as! [LCategory]
            
        } catch {
            print("Failed Loading Category")
        }
        return data
    }
    
    class func GetCategoriesByID(id:String, context: NSManagedObjectContext) -> LCategory{
        var data:LCategory!
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LCategory")
        request.predicate = NSPredicate(format: "lId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result.first as! LCategory
            
        } catch {
            print("Failed Loading Category by id")
        }
        return data
    }
    
    class func SearchCategoryByName(name:String, context: NSManagedObjectContext) -> [LCategory]{
        var data:[LCategory] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LCategory")
        request.predicate = NSPredicate(format: "lName == %@", name)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result as! [LCategory]
            
        } catch {
            print("Failed Loading Artists by name")
        }
        return data
    }
    
    class func SetDefaultValues(context: NSManagedObjectContext) {
        // Initialize Fetch Request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LCategory")
        // Configure Fetch Request
        request.includesPropertyValues = false
        
        do {
            let items = try context.fetch(request) as! [NSManagedObject]
            
            if items.count != 1{ 
                for item in items {
                    context.delete(item)
                }
                saveCateory(context: context)
                // Save Changes
                try context.save()
            }
            
        } catch {
            print("error deleting categories")
        }
    
    }
    
    class func saveCateory(context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: "LCategory", in: context)
        let newArtist = NSManagedObject(entity: entity!, insertInto: context)
        newArtist.setValue("POP", forKey: "lName")
        newArtist.setValue(1, forKey: "lId")
        
        do {
            try context.save()
        } catch {
            print("Failed saving Category")
        }
        
    }
}
