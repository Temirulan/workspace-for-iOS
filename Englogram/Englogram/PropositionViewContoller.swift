//
//  GrammarViewContoller.swift
//  Englogram
//
//  Created by Mussayev Temirulan Zamirbekovich on 4/3/15.
//  Copyright (c) 2015 Mussayev Temirulan. All rights reserved.
//

import Foundation
import UIKit

class PropositionViewContoller : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var list = [Article]()
    
    @IBOutlet var propositionTableView: UITableView!
    let textCellIdentifier = "TextCell"
    
    func getJSONData(url1: NSString) -> NSString {
        let url = NSURL(fileURLWithPath: url1 as String)
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
        
        if (reply != nil) {
        
            let results = NSString(data:reply!, encoding:NSUTF8StringEncoding)
        
            return results!
        } else {
            return ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        propositionTableView.delegate = self
        propositionTableView.dataSource = self
        
        let val = getJSONData("http://forum.pioner24.kg/site/api")
        let new_data = val.dataUsingEncoding(NSUTF8StringEncoding)!
        
        let json = JSON(data: new_data)
        
        for i in 0...(json.count-1) {
            let id = json[i]["id"].description
            let name = json[i]["name"].description
            let title = json[i]["title"].description
            let content = json[i]["content"].description
            let date = json[i]["created"].description
            let category = json[i]["cat_id"].description
            let temp = json[i]["status"].description
            var status = true
            if category == "Proposition" {
                var x = Article(id: id, name: name, title: title, content: content, date: date, category: category, status: true)
                self.list.append(x)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = list[row].content
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(list[row])
    }
    
}
