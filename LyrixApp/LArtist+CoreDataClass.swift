//
//  LArtist+CoreDataClass.swift
//  LyrixApp
//
//  Created by sachila on 5/20/18.
//  Copyright © 2018 Infinity. All rights reserved.
//
//

import Foundation
import CoreData

@objc(LArtist)
public class LArtist: NSManagedObject {
    
    class func SaveArtists(artist: artists, context: NSManagedObjectContext)-> Bool {
        var item = true;
        let entity = NSEntityDescription.entity(forEntityName: "LArtist", in: context)
        let newArtist = NSManagedObject(entity: entity!, insertInto: context)
        
        let random =  Int(arc4random_uniform(99999) + 100)
        newArtist.setValue(random, forKey: "aId")
        newArtist.setValue(artist.artistName, forKey: "aName")
        newArtist.setValue(artist.artistImage, forKey: "aImage")
        
        do {
            try context.save()
        } catch {
            print("Failed saving Artist")
            item = false
        }
        return item;
        
    }
    
    class func GetAllArtists(context: NSManagedObjectContext) -> [LArtist]{
        var data:[LArtist] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LArtist")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result as! [LArtist]
            
        } catch {
            print("Failed Loading Artists")
        }
        return data
    }
    
    class func GetArtistByID(id:String, context: NSManagedObjectContext) -> LArtist{
        var data:LArtist?
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LArtist")
        request.predicate = NSPredicate(format: "aId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result.first as? LArtist;
            
        } catch {
            print("Failed Loading Artists by id")
        }
        return data!
    }
    
    class func SearchArtistsByName(name:String, context: NSManagedObjectContext) -> [LArtist]{
        var data:[LArtist] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LArtist")
        request.predicate = NSPredicate(format: "aName == %@", name)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result as! [LArtist]
            
        } catch {
            print("Failed Loading Artists by name")
        }
        return data
    }
    
    class func RemoveArtistById(id:String, context: NSManagedObjectContext) -> Bool{
        var item = false;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LArtist")
        request.predicate = NSPredicate(format: "aId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for item in result {
                context.delete(item)
            }
            try context.save()
            item = true
        } catch {
            print("Failed to remove Artist by id")
        }
        return item
    }
    
    

}
