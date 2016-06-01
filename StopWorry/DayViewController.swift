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

class DayViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet var backButtton: UIButton!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var addRant: UIButton!
    
    let cellID = "cellID"
    
    // CREATE A PLACEHOLDER NOTE. ADD NEW PLACEHLDER EVERY TIME NEW NOTE IS MADE.
    
    var masterDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    
    func noteSetup() {
        clearNotes()

        makeNotes()
        
        loadNotes()
    }
    
    func newNote(content: String, context: NSManagedObjectContext, day: Day) {
        let note = NSEntityDescription.insertNewObjectForEntityForName("HappyNote", inManagedObjectContext: context) as! HappyNote
        note.date = day
        note.time = NSDate()
        note.content = content
    }
    
    func clearNotes() {
        if let context = masterDelegate?.managedObjectContext {
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
    
    func makeNotes() {
        if let context = masterDelegate?.managedObjectContext {
            let day = NSEntityDescription.insertNewObjectForEntityForName("Day", inManagedObjectContext: context) as! Day
            day.day = NSDate()
            
            /* TESTING NSDATE
             let test = day.day
             let dateFormatter = NSDateFormatter()
             dateFormatter.dateFormat = "MM/dd/YYYY hh:mm a"
             print(dateFormatter.stringFromDate(test!))
             */
            
            newNote("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed libero a dui pulvinar mollis et in felis.", context: context,  day: day)
            //newNote("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed libero a dui pulvinar mollis et in felis. Proin porta eros dui, ut rhoncus diam mattis eu. Mauris eu nibh porttitor, sagittis massa nec, pretium risus. Vivamus eget orci tellus. Ut sollicitudin arcu a suscipit hendrerit.", context: context, day: day)
            //newNote("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed libero a dui pulvinar mollis et in felis. Proin porta eros dui, ut rhoncus diam mattis eu. Mauris eu nibh porttitor, sagittis massa nec, pretium risus. Vivamus eget orci tellus. Ut sollicitudin arcu a suscipit hendrerit. Morbi auctor metus ornare pulvinar blandit. Nullam eget sagittis nunc, et bibendum augue. Vestibulum id est tincidunt elit placerat molestie. Etiam auctor ante turpis.", context: context, day: day)
            
            if (noteMgr.count == 0) {
                newNote("", context: context, day: day)
            } else if (noteMgr[noteMgr.count - 1].content != "") {
                newNote("", context: context, day: day)
            }
            
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
        }
    }
    
    func loadNotes() {
        if let context = masterDelegate?.managedObjectContext {
            let fetch = NSFetchRequest(entityName: "HappyNote")
            fetch.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
            
            do {
                noteMgr = try(context.executeFetchRequest(fetch)) as!  [HappyNote]
            } catch let err {
                print(err)
            }
        }
    }
    
    var path: NSIndexPath?
    var prevCell: HappyCell?
    var isLast = false
    var lastIndex = 0
    
    func handleTap(gesture: UITapGestureRecognizer) {
        if (gesture.state != UIGestureRecognizerState.Ended) {
            return
        }
        
        let touch = gesture.locationInView(self.collectionView)
        path = self.collectionView!.indexPathForItemAtPoint(touch)
        //print("item at path: \(path!.item)")
        
        if let index = path {
            let cell = self.collectionView!.cellForItemAtIndexPath(index) as! HappyCell
            cell.textView.becomeFirstResponder()
            
            if (cell != prevCell && !isLast) {
                if let prev = prevCell {
                    if !(prev.textView.hasText()) {
                        prev.hidden = true
                        // THIS IS VERY GLITCHY
                        
                        if let context = masterDelegate?.managedObjectContext {
                            do {
                                context.deleteObject(noteMgr[lastIndex])
                                noteMgr.removeAtIndex(lastIndex)
                                
                                print("cell is removed, noteMgr: \(noteMgr.count)")
                                try(context.save())
                            } catch let err {
                                print(err)
                            }
                        }
                        
                        self.collectionView!.deleteItemsAtIndexPaths([NSIndexPath(forItem: lastIndex, inSection: path!.section)])
                    }
                }
            }
            
            if (path!.item != (noteMgr.count - 1)) {
                if noteMgr[noteMgr.count - 1].content != "" {
                    emptyNote()
                    self.collectionView!.insertItemsAtIndexPaths([NSIndexPath(forItem: noteMgr.count - 1, inSection: path!.section)])
                }
                
                isLast = false
                lastIndex = path!.item
            } else {
                isLast = true
            }
            
            prevCell = cell
        }
    }
    
    func emptyNote() {
        if let context = masterDelegate?.managedObjectContext {
            let day = NSEntityDescription.insertNewObjectForEntityForName("Day", inManagedObjectContext: context) as! Day
            day.day = NSDate()
            
            newNote("", context: context, day: day)
            
            do {
                try(context.save())
                loadNotes()
            } catch let err {
                print(err)
            }
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        // DON'T MESS WITH THIS CODE!!!
        if let index = path {
            let cell = self.collectionView!.cellForItemAtIndexPath(index) as! HappyCell
            cell.placeholder.hidden = cell.textView.hasText()
            noteMgr[index.item].content = cell.textView.text
            
            // RESIZING CELL
            let fixedWidth = cell.frame.size.width
            cell.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
            cell.frame.size = CGSize(width: fixedWidth, height: newSize.height)
            
            if let context = masterDelegate?.managedObjectContext {
                do {
                    try(context.save())
                } catch let err {
                    print(err)
                }
            }
            
            self.collectionView!.reloadItemsAtIndexPaths([path!])
            let newCell = self.collectionView!.cellForItemAtIndexPath(index) as! HappyCell
            newCell.textView.becomeFirstResponder()
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
        noteRecognizer.delegate = self
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
        
        return CGSizeMake(view.frame.width, newFrame.height + 20)
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
        view.backgroundColor = UIColor(red: 204.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0) // CHANGE THIS COLOR
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