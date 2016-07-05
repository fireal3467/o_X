
//
//  WebService.swift
//  NoughtsAndCrosses
//
//  Created by Julian Hulme on 2016/06/04.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class WebService {
    
    
    //MARK:- Utility request creation methods
    func createMutableRequest(url:NSURL!,method:String!,parameters:Dictionary<String, String>?) -> Request  {
        
        // build request
        let headers = ["access-Token":UserController.sharedInstance.currentUser!.token, "client": UserController.sharedInstance.currentUser!.client, "uid":UserController.sharedInstance.currentUser!.email, "token-type":"bearer"]
        
        let request = Alamofire.request(Method(rawValue:method)!, url, parameters: parameters, encoding: .URL, headers: headers)
        
        return request
    }
    
    func createMutableAnonRequest(url:NSURL!,method:String!,parameters:Dictionary<String, String>?) -> Request  {
        
        
        // build request
        let request = Alamofire.request(Method(rawValue:method)!, url, parameters: parameters, encoding: .URL)
        
        return request
    }
    
    func executeRequest (urlRequest:Request, presentingViewController:UIViewController? = nil, requestCompletionFunction:(Int,JSON) -> ())  {
        
        //add a loading overlay over the presenting view controller, as we are about to wait for a web request
       // presentingViewController?.addLoadingOverlay()
        
        urlRequest.responseJSON { returnedData -> Void in  //execute the request and give us JSON response data
            
            //the web service is now done. Remove the loading overlay
          //  presentingViewController?.removeLoadingOverlay()
            
            //Handle the response from the web service
            let success = returnedData.result.isSuccess
            if (success) {
                
                var json = JSON(returnedData.result.value!)
                let serverResponseCode = returnedData.response!.statusCode //since the web service was a success, we know there is a .response value, so we can request the value gets unwrapped with .response!
                
                //                let headerData = returnedData.response?.allHeaderFields
                //                print ("token data \(headerData)")
                
                
                if let validToken = returnedData.response!.allHeaderFields["Access-Token"] {
                    let tokenJson:JSON = JSON(validToken)
                    json["data"]["token"] = tokenJson
                }
                if let validClient = returnedData.response!.allHeaderFields["Client"] as? String    {
                    let clientJson:JSON = JSON(validClient)
                    json["data"]["client"] = clientJson
                }
                
                //execute the completion function specified by the class that called this executeRequest function
                //the
                requestCompletionFunction(serverResponseCode,json)
                
            }   else    {
                //execute the completion function specified by the class that called this executeRequest function
                
                //print(returnedData.response?.statusCode)
                
                requestCompletionFunction(0,JSON(""))
            }
        }
    }
    
}