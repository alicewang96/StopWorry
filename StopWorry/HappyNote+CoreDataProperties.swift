//
//  HappyNote+CoreDataProperties.swift
//  StopWorry
//
//  Created by Natsuki Takahari on 5/25/16.
//  Copyright © 2016 Alice Wang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HappyNote {

    @NSManaged var content: String?
    @NSManaged var time: NSDate?
    @NSManaged var date: Day?

}
