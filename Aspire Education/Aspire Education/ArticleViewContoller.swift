//
//  ArticleViewContoller.swift
//  Aspire Education
//
//  Created by Mussayev Temirulan Zamirbekovich on 4/21/15.
//  Copyright (c) 2015 Mussayev Temirulan. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewContoller: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var name: String = ""
    
    var myData: Array<Article> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        headerNav.title! = name
        tableView.delegate = self
        tableView.dataSource = self
        
        var tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.hidden = true
        tableView.backgroundColor = UIColor.whiteColor()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80.0
        
        fillData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
        if reply == nil {
            return ""
        }
        
        if let results = NSString(data:reply!, encoding:NSUTF8StringEncoding) {
            return results
        } else {
            return ""
        }
    }
    
    func fillData() {
        
        var val = getJSONData("http://forum.pioner24.kg/site/api")
        
        while val == "" {
            val = getJSONData("http://forum.pioner24.kg/site/api")
        }
        
        let new_data = val.dataUsingEncoding(NSUTF8StringEncoding)!
        
        println(val);
        
        let json = JSON(data: new_data)
        
        println("_________")
        println(json.count)
        println("_________")
        
        if myData.count > 0 {
            myData = myData.reverse()
        }
        
        for i in 0...(json.count-1) {
            let id = json[i]["id"].description
            let name = json[i]["name"].description
            let title = json[i]["title"].description
            let content = json[i]["content"].description
            let date = json[i]["created"].description
            let category = json[i]["cat_id"].description
            let temp = json[i]["status"].description
            var status = true
            if category == "Grammar" && temp == "1" {
                var x = Article(id: id, name: name, title: title, content: content, date: date, category: category, status: true)
                println(x.description)
                println("_________")
                var y: Bool = false
                if myData.count > 0 {
                    for i in 0...myData.count-1 {
                        if x.id == myData[i].id {
                            y = true
                        }
                    }
                }
                if y == false {
                    myData.append(x)
                }
            }
        }
        
        println("it is the end of fucking program")
        
        myData = myData.reverse()
        
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ArticleTableViewCellClass = tableView.dequeueReusableCellWithIdentifier("cell") as! ArticleTableViewCellClass
        
        var content: NSString = myData[indexPath.row].content as NSString
        
        if content.length > 200 {
            content = content.substringToIndex(200) + "..."
        }
        
        cell.headerLabel?.text = myData[indexPath.row].name as String
        cell.contentLabel?.text = content as String
        cell.dateLabel?.text = myData[indexPath.row].date as String
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
}