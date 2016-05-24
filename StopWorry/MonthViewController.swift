//
//  MonthViewController.swift
//  StopWorry
//
//  Created by Alice Wang on 5/17/16.
//  Copyright © 2016 Alice Wang. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
// PROGRAMMATIC CONSTRAINT ITEMS HERE
    
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var sun: UILabel!
    @IBOutlet var mon: UILabel!
    @IBOutlet var tue: UILabel!
    @IBOutlet var wed: UILabel!
    @IBOutlet var thu: UILabel!
    @IBOutlet var fri: UILabel!
    @IBOutlet var sat: UILabel!
    
// END PROGRAMMATIC CONSTRAINT ITEMS HERE
    
    
// COLLECTION VIEW ITEMS

    @IBOutlet var mainCollectionView: UICollectionView!
    
    
    
// DATA
    
    var days = [String]()
    var ind = Int()
    var offset = 0
    func getData(receive: Int) {
        if receive == 0 {
            let d = NSDate()
            self.monthLabel.text = d.monthString()
            
            let numDays = d.getNumDaysInMonth()
            for i in 1...numDays {
                days.append(String(i))
            }
            
        } else if receive == 1 {
            //load previous month's data
        } else {
            //load next month's data
        }
    }
    @IBAction func prevMonth(sender: AnyObject) {
        getData(1)
        mainCollectionView.reloadData()
    }
    
    @IBAction func nextMonth(sender: AnyObject) {
            getData(2)
        mainCollectionView.reloadData()
    }
    
// END DATA
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(0)
        
        self.view.backgroundColor = UIColor.whiteColor()
        mainCollectionView.backgroundColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// FUNCTIONS FOR COLLECTION VIEW
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toDay", sender: indexPath)
        ind = indexPath.row
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCellWithReuseIdentifier("monthCell", forIndexPath: indexPath) as! DayCollectionViewCell
        cell.dayNumber.text = days[indexPath.row]
        return cell
    }
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        ind = indexPath.row
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! DayViewController
        print(ind)
        vc.dayLabel.text = days[ind]
      
    }

}
