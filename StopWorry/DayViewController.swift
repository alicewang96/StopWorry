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
import CoreData



var noteMgr = [HappyNote]()

class DayViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
    @IBOutlet var backButtton: UIButton!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var addRant: UIButton!
    
    let cellID = "cellID"
    
    // CREATE A PLACEHOLDER NOTE. ADD NEW PLACEHLDER EVERY TIME NEW NOTE IS MADE.
    
    func noteSetup() {
        clearNotes()
        
        /*
         HappyNote Properties:
         content = String
         time = NSDate
         day = Day
         
         a. New HappyNote takes in USERINPUT. HappyCell adjusts HEIGHT depending on input.
         b. HappyNote can be deleted.
         c. One Day view per calender day that multiple HappyNotes map to.
        */
        
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let context = delegate?.managedObjectContext {
            let day = NSEntityDescription.insertNewObjectForEntityForName("Day", inManagedObjectContext: context) as! Day
            day.day = NSDate()
            
            /* TESTING NSDATE
            let test = day.day
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/YYYY hh:mm a"
            print(dateFormatter.stringFromDate(test!))
            */
            
            makeNote("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed libero a dui pulvinar mollis et in felis.", context: context,  day: day)
            //makeNote("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed libero a dui pulvinar mollis et in felis. Proin porta eros dui, ut rhoncus diam mattis eu. Mauris eu nibh porttitor, sagittis massa nec, pretium risus. Vivamus eget orci tellus. Ut sollicitudin arcu a suscipit hendrerit.", context: context, day: day)
            //makeNote("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed libero a dui pulvinar mollis et in felis. Proin porta eros dui, ut rhoncus diam mattis eu. Mauris eu nibh porttitor, sagittis massa nec, pretium risus. Vivamus eget orci tellus. Ut sollicitudin arcu a suscipit hendrerit. Morbi auctor metus ornare pulvinar blandit. Nullam eget sagittis nunc, et bibendum augue. Vestibulum id est tincidunt elit placerat molestie. Etiam auctor ante turpis.", context: context, day: day)
            
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
            
            loadNotes()
            
            if (noteMgr.count == 0) {
                makeNote("", context: context, day: day)
                
                do {
                    try(context.save())
                } catch let err {
                    print(err)
                }
            } else if (noteMgr[noteMgr.count - 1].content != "") {
                makeNote("", context: context, day: day)
             
                do {
                    try(context.save())
                } catch let err {
                    print(err)
                }
            }
        }
        
        loadNotes()
    }
    
    func makeNote(content: String, context: NSManagedObjectContext, day: Day) {
        let note = NSEntityDescription.insertNewObjectForEntityForName("HappyNote", inManagedObjectContext: context) as! HappyNote
        note.date = day
        note.time = NSDate()
        note.content = content
    }
    
    func clearNotes() {
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let context = delegate?.managedObjectContext {
            
            do {
                let entities = ["Day", "HappyNote"]
                for entity in entities {
                    let fetch = NSFetchRequest(entityName: entity)
                    let objects = try(context.executeFetchRequest(fetch)) as? [NSManagedObject]
                    for each in objects! {
                        context.deleteObject(each)
                    }
                }
                
                try(context.save())
            } catch let err {
                print(err)
            }
        }
    }
    
    func loadNotes() {
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let context = delegate?.managedObjectContext {
            let fetch = NSFetchRequest(entityName: "HappyNote")
            fetch.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)] // should sort by recent
            
            do {
                noteMgr = try(context.executeFetchRequest(fetch)) as!  [HappyNote]
            } catch let err {
                print(err)
            }
        }
    }
    
    var path: NSIndexPath?
    
    func handleTap(gesture: UITapGestureRecognizer) {
        if (gesture.state != UIGestureRecognizerState.Ended) {
            return
        }
        
        let touch = gesture.locationInView(self.collectionView)
        path = self.collectionView!.indexPathForItemAtPoint(touch)
        
        if let index = path {
            let cell = self.collectionView!.cellForItemAtIndexPath(index) as! HappyCell
            cell.textView.becomeFirstResponder()
            //print("isFirstResponder: \(cell.textView.isFirstResponder())")
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        // DON'T MESS WITH THIS CODE!!!
        if let index = path {
            let cell = self.collectionView!.cellForItemAtIndexPath(index) as! HappyCell
            cell.placeholder.hidden = cell.textView.hasText()
            
            // RESIZING CELL
            let fixedWidth = cell.frame.size.width
            cell.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
            var newFrame = cell.frame
            newFrame.size = CGSize(width: fixedWidth, height: newSize.height)
            
            cell.frame = newFrame
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Navigation bar title.
        // NEED TO ADD NAVIGATION FOR PREV AND NEXT DAY.
        navigationItem.title = "< Monday >"
        
        collectionView?.backgroundColor = UIColor(red: 245.0/255.0, green: 215.0/255.0, blue: 209.0/255.0, alpha: 1.0) // BACKGROUND COLOR
        collectionView?.registerClass(HappyCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.alwaysBounceVertical = true
        collectionView?.allowsSelection = true
        
        addRant = rantButton("NEW RANT")
        view.addSubview(addRant)
        view.addConstraintFormat("H:|[v0]|", views: addRant)
        view.addConstraintFormat("V:[v0]|", views: addRant)
        
        noteSetup()
    }

    func rantButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = UIColor.redColor()
        return button
    }

    
    // ROWS
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noteMgr.count
    }
    
    // CELLS
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! HappyCell
        cell.textView.delegate = self
        cell.setText(noteMgr[indexPath.item].content!)
        cell.placeholder.hidden = cell.textView.hasText()
        
        let noteRecognizer = UITapGestureRecognizer(target: self, action: #selector(DayViewController.handleTap))
        cell.textView.addGestureRecognizer(noteRecognizer)

        return cell
    }
    
    // CELL SIZE
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // AUTO LAYOUT HEIGHT
        let noteText = noteMgr[indexPath.item].content!
        let size = CGSizeMake(view.frame.width, view.frame.height)
        let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
        let newFrame = NSString(string: noteText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
        
        // print(newFrame.height)
        return CGSizeMake(view.frame.width, newFrame.height + 20) // FIND BETTER WAY OF CALC HEIGHT
    }
    
    // CELL DISTANCE
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
}

/* ########## Extra Functions ########## */


class HappyCell: NoteCell, UITextViewDelegate {
    func setText(text: String) {
        textView.text = text
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 204.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8) // CHANGE THIS COLOR
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFontOfSize(16)
        view.backgroundColor = UIColor.clearColor()
        view.allowsEditingTextAttributes = true
        view.scrollEnabled = false
        return view
    }()
    
    let placeholder: UILabel = {
        let label = UILabel()
        label.text = "Add a new happy thought!"
        label.font = UIFont.systemFontOfSize(16)
        label.textColor = UIColor.lightGrayColor()
        return label
    }()
    
    override func pageSetup() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addConstraintFormat("H:|[v0]|", views: containerView)
        addConstraintFormat("V:|[v0]|", views: containerView)
        
        addSubview(placeholder)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        addConstraintFormat("H:|-10-[v0]", views: placeholder)
        addConstraintFormat("V:|-10-[v0]", views: placeholder)

        
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        addConstraintFormat("H:|-5-[v0]-5-|", views: textView)
        addConstraintFormat("V:|[v0]|", views: textView)
    }

}

extension UIView {
    func addConstraintFormat(format: String, views: UIView...) {
        var dict = [String: UIView]()
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            dict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: dict))
    }
}

class NoteCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        pageSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pageSetup() {
        // CODE
    }
}


/* HOW TO DO EXTENSION */

//extension UITextView: UITextViewDelegate {
//    var placeholder: UILabel? {
//        get {
//            return placeholderLabel
//        }
//    }
//
//    func remove(set: Bool) {
//        placeholder!.hidden = set
//    }
//}

//let placeholderLabel: UILabel = {
//    let view = UILabel()
//    view.text = "Add a new happy thought!"
//    view.font = UIFont.systemFontOfSize(16)
//    view.textColor = UIColor.lightGrayColor()
//    view.hidden = false
//    return view
//}()