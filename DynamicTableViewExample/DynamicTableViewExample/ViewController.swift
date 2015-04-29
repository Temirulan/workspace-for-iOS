//
//  ViewController.swift
//  DynamicTableViewExample
//
//  Created by Mussayev Temirulan Zamirbekovich on 4/17/15.
//  Copyright (c) 2015 Mussayev Temirulan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var textArray: NSMutableArray! = NSMutableArray()
    var list = [Article]()
    var refreshControl:UIRefreshControl!
    
    func getJSONData(url1: NSString) -> NSString {
        let url = NSURL(string:url1 as String)
        let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var request = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 2.0)
        request.HTTPMethod = "POST"
        
        let boundaryConstant = "----------V2ymHFg03esomerandomstuffhbqgZCaKO6jy";
        let contentType = "multipart/form-data; boundary=" + boundaryConstant
        NSURLProtocol.setProperty(contentType, forKey: "Content-Type", inRequest: request)
        
        var dataString = ""
        let requestBodyData = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = requestBodyData
        
        var response: NSURLResponse? = nil
        var error: NSError? = nil
        let reply = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
        
        let results = NSString(data:reply!, encoding:NSUTF8StringEncoding)
        
        return results!
    }
    
    func downloadData() {
        let val = getJSONData("http://forum.pioner24.kg/site/api")
        let new_data = val.dataUsingEncoding(NSUTF8StringEncoding)!
        
        let json = JSON(data: new_data)
        
        self.list.removeAll(keepCapacity: true)
        
        for i in 0...(json.count-1) {
            let id = json[i]["id"].description
            let name = json[i]["name"].description
            let title = json[i]["title"].description
            let content = json[i]["content"].description
            let date = json[i]["created"].description
            let category = json[i]["cat_id"].description
            let temp = json[i]["status"].description
            var status = true
            var x = Article(id: id, name: name, title: title, content: content, date: date, category: category, status: true)
            self.list.append(x)
        }
        
        self.textArray.removeAllObjects()
        
        for i in 0...self.list.count-1 {
            var ind = self.list.count-1-i
            self.textArray.addObject(self.list[ind].content)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.downloadData()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject)
    {
        // Code to refresh table view
        self.downloadData()
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.textArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.textArray.objectAtIndex(indexPath.row) as? String
        
        return cell
    }
}

