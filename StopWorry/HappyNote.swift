//
//  HappyNote.swift
//  StopWorry
//
//  Created by Natsuki Takahari on 5/25/16.
//  Copyright © 2016 Alice Wang. All rights reserved.
//

import Foundation
import CoreData


class HappyNote: NSManagedObject {
    func format() -> NSDictionary {
        return ["content": content!, "time": time!, "day": date!]
    }
    
    // Use NSUserDefaults
    class func setDefaults() {
        var objects: [NSDictionary] = []
        for i:Int in 0 ..< noteMgr.count {
            objects.append(noteMgr[i].format())
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(objects, forKey: "content")
        defaults.synchronize()
    }
    
    class func loadDefaults(index: NSIndexPath) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let saved:[NSDictionary] = defaults.objectForKey("content") as! [NSDictionary]
        if let data:[NSDictionary] = saved {
            for i:Int in 0 ..< data.count {
                let n:HappyNote = HappyNote()
                n.setValuesForKeysWithDictionary(data[i] as! [String : AnyObject])
                noteMgr.append(n)
                
            }
        }
    }
}
