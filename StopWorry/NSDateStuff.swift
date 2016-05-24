//
//  NSDateStuff.swift
//  StopWorry
//
//  Created by Alice Wang on 5/24/16.
//  Copyright © 2016 Alice Wang. All rights reserved.
//


import Foundation

extension NSDate
{
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    func day() -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: self)
        let day = components.day
        return day
    }
    func month() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        let month = components.month
        return month
    }
    func monthString() -> String {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        let month = components.month
        var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        return months[month - 1]
        
    }
    func getNumDaysInMonth() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        let month = components.month
        var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        let theMonth = months[month]
        let twentyeight = ["February"]
        let thirty = ["April", "June", "September", "November"]
        let thirtyone = ["January", "March", "May", "July", "August", "October", "December"]
        if twentyeight.contains(theMonth) {
            return 28
        } else if thirty.contains(theMonth){
            return 30
        } else {
            return 31
        }
    }
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
}

