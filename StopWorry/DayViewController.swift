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
    
    @IBOutlet var addHappy: UIButton!
    @IBOutlet var addRant: UIButton!
    
// END PROGRAMMATIC CONSTRAINT ITEMS HERE
    

// NOTE HANDLING
    
    var ind = Int()
    @IBOutlet var mainTableView: UITableView!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.delegate = self
        mainTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// TABLE VIEW FUNCTIONS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        self.performSegueWithIdentifier(<#T##identifier: String##String#>, sender: <#T##AnyObject?#>)
        ind = indexPath.row
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = mainTableView.dequeueReusableCellWithReuseIdentifier("dayCell", forIndexPath: indexPath) as! ThoughtTableViewCell
        let cell = mainTableView.dequeueReusableCellWithIdentifier("dayCell", forIndexPath: indexPath) as! ThoughtTableViewCell
        
//        cell.Thoughts.text = thoughts[ind]
        return cell
    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        return
//    }


}
