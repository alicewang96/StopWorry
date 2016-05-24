//
//  RantViewController.swift
//  StopWorry
//
//  Created by Alice Wang on 5/17/16.
//  Copyright © 2016 Alice Wang. All rights reserved.
//
//  Adapted from Brian Voong.
//

/* --------------------------------------------------------------------
 GOAL
    Create an environment resembling a messaging system.
 
    Design: similar to FB messaging.
     -> need to decide on: color of messages
        possibility to choose color?
    Function: type "rants" which disappear in (DESIGNATED TIME PERIOD).
     -> find out how to implement this
 
 -------------------------------------------------------------------- */

import UIKit
import Foundation
import CoreData

class Rant: NSObject {
    @NSManaged var text: String?
}

class RantViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let rantId = "rantId"
    
    var allRants: [Rant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(RantCell.self, forCellWithReuseIdentifier: rantId)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allRants!.count
    }
    
    /*
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(rantId, forIndexPath: indexPath) as! RantCell
        
        cell.textDesign.text = allRants?[indexPath.item].text
        
        if let messageText = allRants?[indexPath.item].text, profileImageName = allRants?[indexPath.item].friend?.profileImageName {
            
            cell.profileImageView.image = UIImage(named: profileImageName)
            
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
            
            cell.messageTextView.frame = CGRectMake(48 + 8, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
            
            cell.textBubbleView.frame = CGRectMake(48, 0, estimatedFrame.width + 16 + 8, estimatedFrame.height + 20)
        }
        
        return cell
    }
    */
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if let messageText = allRants?[indexPath.item].text {
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
            
            return CGSizeMake(view.frame.width, estimatedFrame.height + 20)
        }
        
        return CGSizeMake(view.frame.width, 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }

}

class RantCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var textDesign: UITextView {
        let rantText = UITextView()
        rantText.font = UIFont.systemFontOfSize(14)
        rantText.text = "Angry rant"
        rantText.backgroundColor = UIColor.clearColor()
        return rantText
    }
    
    var textBubble: UIView {
        let bubble = UIView()
        bubble.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        bubble.layer.cornerRadius = 15
        bubble.layer.masksToBounds = true
        return bubble
    }
    
    func setupViews() {
        addSubview(textBubble)
        addSubview(textDesign)
    }
}
