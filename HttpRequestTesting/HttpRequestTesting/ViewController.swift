//
//  ViewController.swift
//  HttpRequestTesting
//
//  Created by Mussayev Temirulan Zamirbekovich on 3/26/15.
//  Copyright (c) 2015 Mussayev Temirulan. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    func getJSONData(url1: NSString) -> String {
        let url = NSURL(string:url1)
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
    
    @IBAction func click() {
        println(getJSONData("http://forum.pioner24.kg/site/api"))
    }

}

