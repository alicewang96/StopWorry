//
//  DayViewController.swift
//  StopWorry
//
//  Created by Alice Wang on 5/17/16.
//  Copyright © 2016 Alice Wang. All rights reserved.
//

import UIKit

class DayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//PROGRAMMATIC CONSTRAINT ITEMS HERE
    @IBOutlet var backButtton: UIButton!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var addHappy: UIButton!
    @IBOutlet var addRant: UIButton!
    
//END PROGRAMMATIC CONSTRAINT ITEMS HERE

//DATA  
    var thoughts = [String]()
//END DATA
    var ind = Int()
    @IBOutlet var mainTableView: UITableView!
    
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
//TABLE VIEW FUNCTIONS
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
