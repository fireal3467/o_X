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
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    var allUsers: [User] = []
    
    var currentUser: User?
    
    
    func register(email: String, password: String , onCompletion: (User?,String?) -> Void) {
        if email == "" {
            onCompletion(nil,"no email entered")
            return
        }
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
        
        defaults.setObject(email, forKey: "currentUserEmail")
        defaults.setObject(password, forKey: "currentUserPassword")
        defaults.synchronize()
        
        print( defaults.objectForKey("currentUserEmail"))
        print( defaults.objectForKey("currentUserPassword"))
        
        let newUser:User = User(emailString: email, passwordString: password)
        currentUser = newUser
        onCompletion(newUser,nil)
       
        
        
    }
    
    func login(email:String, password: String, onCompletion: (User?,String?) -> Void) {
        for user in allUsers {
            if (user.email == email && user.password == password) {
                onCompletion(user,nil)
                
                defaults.setObject(email, forKey: "currentUserEmail")
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                
                return
            }
        }
        
        
        onCompletion(nil,"Your username or password is incorrect")
        
    }
    
    func logout(onCompletion:(String?) -> Void) {
        
        currentUser = nil
        
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserPassword")
        defaults.synchronize()
        
        
        
    }
    
    
    
    
    
    
}