// Playground - noun: a place where people can play

import UIKit
import XCPlayground

func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) -> String {
    var session = NSURLSession.sharedSession()
    var cur = "123"
    var task = session.dataTaskWithRequest(request){
        (data, response, error) -> Void in
        if error != nil {
            callback("", error.localizedDescription)
        } else {
            var result = NSString(data: data, encoding:
                NSASCIIStringEncoding)!
            callback(result, nil)
            cur = cur + result
        }
    }
    task.resume()
    return cur
}

var request = NSMutableURLRequest(URL: NSURL(string: "http://forum.pioner24.kg/site/api")!)

var result = httpGet(request){
    (data, error) -> Void in
}

println(result)

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)
