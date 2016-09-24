//
//  NetManager.swift
//  WantList
//
//  Created by SDLL18 on 15/1/10.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

import Foundation
//import SwiftHTTP

class NetManger {
    
    
    func getRequest(){
        var request = HTTPTask()
        request.GET("http://google.com", parameters: ["param": "param1", "array": ["first array element","second","third"], "num": 23], success: {(response: HTTPResponse) -> Void in
            println("response: \(response.responseObject!)")
            },failure: {(error: NSError,response:HTTPResponse?) -> Void in
                println("error: \(error)")
        })
    }
    
    func getPost(){
        var request =  HTTPTask()
        request.POST("http://google.com",parameters:["param":"123"],success:{(response:HTTPResponse)->Void in
            println("response: \(response.responseObject!)")
            },failure:{(error:NSError,response:HTTPResponse?)->Void in
                println("error:\(error)")
        })
    }
    
}
