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
        
        restartGame()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
   
    
    func restartGame() {
        OXGameController.sharedInstance.restartGame()
        for subview in BoardView.subviews {
            if let button = subview as? UIButton {
                button.setTitle("", forState: .Normal)
            }
        }
       
    }
    
 
    
    @IBAction func LogoutTappedUp(sender: UIButton) {
        print("logOut tapped")
    }
    
    @IBAction func NewGameTappedUp(sender: UIButton) {
        print("NewGameTappedUP")
        restartGame()
        
    }
  
    @IBAction func ButtonTappedUp(sender: UIButton) {
        if(OXGameController.sharedInstance.getCurrentGame().state() == .InProgress && sender.titleForState(.Normal)!.isEmpty) {
            
        sender.setTitle(OXGameController.sharedInstance.getCurrentGame().whoseTurn().rawValue, forState: .Normal)
        OXGameController.sharedInstance.playMove(Int(sender.tag) - 1 )
        
        print(OXGameController.sharedInstance.getCurrentGame().state().rawValue)
        
        switch OXGameController.sharedInstance.getCurrentGame().state() {
            case .Won:
                print("GAME WON WHOO HOO")
            case .Tie:
                print("Game tied? press newGame")
            case .InProgress:
                print("game in progress")
            }
        }
    }
    
    
}

