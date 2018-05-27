//
//  LSongs+CoreDataClass.swift
//  LyrixApp
//
//  Created by sachila on 5/20/18.
//  Copyright © 2018 Infinity. All rights reserved.
//
//

import Foundation
import CoreData

@objc(LSongs)
public class LSongs: NSManagedObject {
    class func SaveSong(song: songs, context: NSManagedObjectContext)-> Bool {
        var item = true;
        let entity = NSEntityDescription.entity(forEntityName: "LSongs", in: context)
        let newSong = NSManagedObject(entity: entity!, insertInto: context)
        
 
        let artists = LArtist.SearchArtistsByName(name:song.artistName!, context: context)
        let category = LCategory.SearchCategoryByName(name: song.categoryName!, context: context)
        
        let random =  Int(arc4random_uniform(99999) + 100)
        print(random)
        
        newSong.setValue(random, forKey: "lId")
        newSong.setValue(song.name, forKey: "lName")
        newSong.setValue(song.url, forKey: "lUrl")
        newSong.setValue(song.lyrics, forKey: "lLyrics")
        newSong.setValue(song.image, forKey: "limage")
        newSong.setValue(artists[0], forKey: "artist")
        newSong.setValue(category[0], forKey: "category")
        // need to add image
        
        do {
            try context.save()
        } catch {
            print("Failed saving Artist")
            item = false
        }
        return item;
        
    }
    class func GetAllSongs(context: NSManagedObjectContext) -> [LSongs]{
        var data:[LSongs] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LSongs")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result as! [LSongs]
            
        } catch {
            print("Failed Loading Songs")
        }
        return data
    }
    
    class func ClearAll(context: NSManagedObjectContext)  {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LSongs")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for item in result {
                context.delete(item)
            }
            try context.save()
            
        } catch {
            print("Failed Loading Songs")
        }
    }
    
    class func GetAllSongsID(id:String, context: NSManagedObjectContext) -> LSongs{
        var data:LSongs? = nil
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LSongs")
        request.predicate = NSPredicate(format: "lId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result.first as? LSongs;
            
        } catch {
            print("Failed Loading Songs by id")
        }
        return data!
    }
    class func SearchSongsByName(name:String, context: NSManagedObjectContext) -> [LSongs]{
        var data:[LSongs] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LSongs")
        request.predicate = NSPredicate(format: "lName == %@", name)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result as! [LSongs]
            
        } catch {
            print("Failed Loading Songs by name")
        }
        return data
    }
    class func QuerySongsByName(name:String, context: NSManagedObjectContext) -> [LSongs]{
        var data:[LSongs] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LSongs")
        request.predicate =  NSPredicate(format: "lName contains[c] %@", name)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result as! [LSongs]
            
        } catch {
            print("Failed Loading Songs by name")
        }
        return data
    }
    
    class func RemoveSongtById(id:String, context: NSManagedObjectContext) -> Bool{
        var item = false;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LSongs")
        request.predicate = NSPredicate(format: "lId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            for item in result {
                context.delete(item)
            }
            try context.save()
            item = true
        } catch {
            print("Failed to remove Songs by id")
        }
        return item
    }
    
    class func GetSongsByArtistId(id:String, context: NSManagedObjectContext) -> [LSongs]{
        var data:[LSongs] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LSongs")
        let artist = LArtist.GetArtistByID(id: id, context: context)
        request.predicate = NSPredicate(format: "artist == %@", artist)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result as! [LSongs]
            
        } catch {
            print("Failed Loading Songs by artist id")
        }
        return data
    }
    
    class func GetSongsByCategoryId(id:String, context: NSManagedObjectContext) -> [LSongs]{
        var data:[LSongs] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LSongs")
        let category = LCategory.GetCategoriesByID(id: id, context: context)
        request.predicate = NSPredicate(format: "category.lId == %@", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            data = result as! [LSongs]
            
        } catch {
            print("Failed Loading Songs by artist id")
        }
        return data
    }
}
