//
//  ViewController.swift
//  SimpleTableView
//
//  Created by Mussayev Temirulan Zamirbekovich on 4/20/15.
//  Copyright (c) 2015 Mussayev Temirulan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var myData : Array<AnyObject>  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myData = ["One", "Two", "Three"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myData.count
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = myData[indexPath.row] as? String
        cell.detailTextLabel!.text = "Additional Info"
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            myData.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

}

