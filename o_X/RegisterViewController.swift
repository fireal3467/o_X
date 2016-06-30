//
//  RegisterViewController.swift
//  o_X
//
//  Created by Alan Yu on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonPressed(sender: UIButton) {
        
        
        let registerClosure = { (user:User?,message:String?) in
            if let newUser = user{
                print("successfully add new user")
                UserController.sharedInstance.allUsers.append(newUser)
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
                
            } else if let errorMessage = message {
                let registerAlert = UIAlertController(title: "Registration failed", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let registerAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                registerAlert.addAction(registerAlertAction)
                
                self.presentViewController(registerAlert, animated: true, completion: nil)
            }
        }
        
        UserController.sharedInstance.register(emailTF.text!, password: passwordTF.text!, onCompletion: registerClosure)
        
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
