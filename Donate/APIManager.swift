//
//  APIController.swift
//  Donate
//
//  Created by özgür on 23.12.2015.
//  Copyright © 2015 ozgur. All rights reserved.
//

import Foundation


func listCharities(completionHandler: (NSArray , NSError?)-> Void)
{
    let urlPath = "https://edheroz.com/api/v2/charities.json?limit=20&page=1"
    let url = NSURL(string: urlPath)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
        print("Task completed")
        if(error != nil) {
            print(error!.localizedDescription)
        }


        guard let jData = data else {return}
        do {
            let parsedData = try NSJSONSerialization.JSONObjectWithData(jData, options: []) as! NSDictionary
             let info : NSArray =  parsedData["charities"] as! NSArray
            completionHandler(info,nil)
        } catch let error {
            print("json error: \(error)")
        }

        
    })

    task.resume()
    
    
}

