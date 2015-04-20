//
//  InterfaceController.swift
//  MoodTrackerWatch WatchKit Extension
//
//  Created by Rommel Rico on 4/20/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    var moods = [String]()

    func refreshTable() {
        var reversedMoods = moods.reverse()
        table.setNumberOfRows(reversedMoods.count, withRowType: "tableRowController")
        for (index, mood) in enumerate(reversedMoods) {
            let row = table.rowControllerAtIndex(index) as! tableRowController
            row.tableRowLabel.setText(mood)
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if NSUserDefaults.standardUserDefaults().objectForKey("moods") != nil {
            moods = NSUserDefaults.standardUserDefaults().objectForKey("moods") as! [String]
        } else {
            moods.append("No moods saved")
        }
        refreshTable()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        if let notificationIndentifier = identifier {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let stringDate = dateFormatter.stringFromDate(NSDate())
            var mood = "\(stringDate) - \(notificationIndentifier)"
            if NSUserDefaults.standardUserDefaults().objectForKey("moods") != nil {
                moods = NSUserDefaults.standardUserDefaults().objectForKey("moods") as! [String]
            }
            moods.append(mood)
            NSUserDefaults.standardUserDefaults().setObject(moods, forKey: "moods")
            refreshTable()
        }
    }
}
