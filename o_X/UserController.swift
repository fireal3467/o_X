//
//  UserController.swift
//  o_X
//
//  Created by Alan Yu on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class UserController {
    
    static var sharedInstance:UserController = UserController()
    
    
    var allUsers: [User] = []
    
    var currentUser: User?
    
    
    func register(email: String, password: String , onCompletion: (User?,String?) -> Void) {
        if password.characters.count < 6 {
            onCompletion(nil,"password too short")
            return
        }
        print("pass password check")
        for user in allUsers {
            if user.email == email {
                onCompletion(nil, "Email already used")
                return
            }
            
        }
        
        let newUser:User = User(emailString: email, passwordString: password)
        currentUser = newUser
        onCompletion(newUser,nil)
    }
    
    func login(email:String, password: String, onCompletion: (User?,String?) -> Void) {
        for user in allUsers {
            if (user.email == email && user.password == password) {
                onCompletion(user,nil)
                return
            }
        }
        onCompletion(nil,"Your username or password is incorrect")
        
    }
    
    func logout(onCompletion:(String?) -> Void) {
        
        
        
        
    }
    
    
    
    
    
    
}