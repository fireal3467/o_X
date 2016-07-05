//
//  User.swift
//  o_X
//
//  Created by Alan Yu on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation


class User {
    var email:String
    var password:String
    var token:String = ""
    var client:String = ""
    
    init(emailString:String, passwordString:String, token:String, client:String) {
        email = emailString
        password = passwordString
    }
    
}

