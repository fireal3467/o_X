//
//  LoginViewController.swift
//  o_X
//
//  Created by Alan Yu on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var EmailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LoginButtonTapped(sender: UIButton) {

        let loginClosure = {(user:User?, message:String?) in
            if let goodUser = user {
    
                UserController.sharedInstance.currentUser = goodUser
            
            print("login successful")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()
            let application = UIApplication.sharedApplication()
            let window = application.keyWindow
            window?.rootViewController = viewController
            
            } else if let errorMessage = message {
                print("error message")
                
                let loginAlert = UIAlertController(title: "login failed", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let loginAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                loginAlert.addAction(loginAlertAction)
                
                self.presentViewController(loginAlert, animated: true, completion: nil)
            }
        }
        
        UserController.sharedInstance.login(EmailTF.text!, password: passwordTF.text!, onCompletion: loginClosure)
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
