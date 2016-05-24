//
//  DayViewController.swift
//  StopWorry
//
//  Created by Alice Wang on 5/17/16.
//  Copyright © 2016 Alice Wang. All rights reserved.
//

/* --------------------------------------------------------------------
 GOAL
    Create an environment where happy "notes" can be recorded.
 
    Design: similar to Notes app.
     -> need to decide on: color of layout/text
     -> change location of RANT button
     -> access to calendar?
        possibly have a "menu"
    Function: type "notes" that accumulate each day
     -> find out how to display notes for that day, not cumulative
     -> previous day cannot add notes
     -> RIGHT/LEFT swiping for prev/next day
 
 -------------------------------------------------------------------- */

import UIKit

class DayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

// PROGRAMMATIC CONSTRAINT ITEMS HERE
    
    @IBOutlet var backButtton: UIButton!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    // @IBOutlet var addHappy: UIButton!
    @IBOutlet var addRant: UIButton!
    
// END PROGRAMMATIC CONSTRAINT ITEMS HERE
    
// TABLE VIEW ITEMS
    
    @IBOutlet var tableView: UITableView!
    
// END TABLE VIEW ITEMS
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// NOTE HANDLING
    
    var noteMgr: HappyNotes = HappyNotes()

    struct note {
        var content = "Today is a great day!"
    }

    class HappyNotes: NSObject {
        var allNotes = [note]()
        
        func newNote(content: String) {
            allNotes.append(note(content: content))
        }
    }
    
// END NOTE HANDLING
    
// TABLE VIEW FUNCTIONS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteMgr.allNotes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = nil
        cell = tableView.dequeueReusableCellWithIdentifier("note", forIndexPath: indexPath)
        
        // SET CONTENT
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // HANDLES SELECTIONS
        // what happens when cell is selected?
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // segue to?
    }

}
