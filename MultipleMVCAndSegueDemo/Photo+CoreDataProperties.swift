//
//  Photo+CoreDataProperties.swift
//  MultipleMVCAndSegueDemo
//
//  Created by iMac on 1/18/17.
//  Copyright © 2017 Dycode. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }

    @NSManaged public var photoId: NSNumber?
    @NSManaged public var photoLink: String?
    @NSManaged public var username: String?

}
