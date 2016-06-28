//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    
    
    @IBOutlet weak var BoardView: UIView!
    
    @IBOutlet weak var LogoutButton: UIButton!
    
    @IBOutlet weak var NewGameButton: UIButton!
    
    //no need for button IBOutlets
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func LogoutTappedUp(sender: UIButton) {
        print("logOut tapped")
    }
    
    @IBAction func NewGameTappedUp(sender: UIButton) {
        print("NewGameTappedUP")
    }
  
    @IBAction func ButtonTappedUp(sender: UIButton) {
        print(String(sender.tag))
        
    }
    
    
}

