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
    
    @IBOutlet var prevMonthButton: UIButton!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var nextMonthButton: UIButton!
    @IBOutlet var sun: UILabel!
    @IBOutlet var mon: UILabel!
    @IBOutlet var tue: UILabel!
    @IBOutlet var wed: UILabel!
    @IBOutlet var thu: UILabel!
    @IBOutlet var fri: UILabel!
    @IBOutlet var sat: UILabel!
    
// END PROGRAMMATIC CONSTRAINT ITEMS HERE
    
// COLLECTION VIEW ITEMS

    @IBOutlet var collectionView: UICollectionView!
    
// END COLLECTION VIEW ITEMS
    
    
// DATA
//    var days = [Int]()
    var days = [1,2,3,4,5,6,7]
// END DATA
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
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
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:DayCollectionViewCell? = nil
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("monthCell", forIndexPath: indexPath) as! DayCollectionViewCell
        
        cell.
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toDay", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! DayViewController
        vc.dayLabel.text =
    }

}
