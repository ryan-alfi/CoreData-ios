//
//  Photo+CoreDataClass.swift
//  MultipleMVCAndSegueDemo
//
//  Created by iMac on 1/18/17.
//  Copyright © 2017 Dycode. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

public class Photo: NSManagedObject {
    
    class func photoWithData(_ data: [String: Any], inManagedObjectContext moc: NSManagedObjectContext) -> Photo? {
        
        var photo: Photo?
        
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "photoId == %@", data["id"] as! NSNumber)
        do {
            let photos = try moc.fetch(fetchRequest)
            
            if photos.count > 0 {
                photo = photos[0]
            }
            else{
                photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: moc) as? Photo
                photo?.photoId = data["id"] as? NSNumber
            }
            
            if let username = data["username"] as? String{
                photo?.username = username
            }
            
            if let photoLink = data["photoLink"] as? String{
                photo?.photoLink = photoLink
            }
            
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        return photo
        
    }
    
    class func photosInManagedObjectContext(_ moc: NSManagedObjectContext) -> [Photo] {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "photoId", ascending: false)]
        
        do{
            let photos = try moc.fetch(fetchRequest) 
            return photos
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return []
    }

}
