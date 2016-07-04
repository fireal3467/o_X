//
//  SettingsViewController.swift
//  o_X
//
//  Created by Alan Yu on 7/4/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var SwitchAI: UISwitch!
    
    @IBAction func cancelButtonPressed(sender:UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SwitchAI.on = OXGameController.sharedInstance.AI
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SwitchFlipped(sender: UISwitch) {
        OXGameController.sharedInstance.AI = sender.on
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
