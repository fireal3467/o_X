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
        
        NewGameButton.hidden = true
        updateBoard()
        print("updated board")
        
        
    }
    
    
    
    func updateBoard() {
        for subview in BoardView.subviews {
            if let button = subview as? UIButton {
                switch OXGameController.sharedInstance.getCurrentGame().checkCell(button.tag - 1) {
                case .X:
                    button.setTitle("X", forState: .Normal)
                case.O:
                    button.setTitle("O", forState: .Normal)
                case.Empty:
                    button.setTitle("", forState: .Normal)
                    
                }
            }
        }
    }
    
    
    func restartGame() {
        OXGameController.sharedInstance.restartGame()
        for subview in BoardView.subviews {
            if let button = subview as? UIButton {
                button.setTitle("", forState: .Normal)
            }
        }
    }
    
 
    
   
    
    @IBAction func NewGameTappedUp(sender: UIButton) {
        print("NewGameTappedUP")
        restartGame()
        NewGameButton.hidden = true
        
    }
    
    
    
    
    
    @IBAction func LogoutButtonTapped(sender: AnyObject) {
        
        
        let logoutClosure = {(message:String?) in
            //nothing for now TTYL
            
            
        }
        
        
        UserController.sharedInstance.logout(logoutClosure)
        
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        let application = UIApplication.sharedApplication()
        let window = application.keyWindow
        window?.rootViewController = viewController

    }
    
    
    
    

    @IBAction func ButtonTappedUp(sender: UIButton) {
        
        
        if(OXGameController.sharedInstance.getCurrentGame().state() == .InProgress && sender.titleForState(.Normal)!.isEmpty) {
        
        OXGameController.sharedInstance.playMove(Int(sender.tag) - 1 )
            sender.setTitle(OXGameController.sharedInstance.getCurrentGame().whoseTurn().rawValue, forState: .Normal)
        print(OXGameController.sharedInstance.getCurrentGame().state().rawValue)
        switch OXGameController.sharedInstance.getCurrentGame().state() {
            case .Won:
               let winner = sender.titleLabel?.text
               print(winner)
               let winAlert = UIAlertController(title: "Winner is " + winner!, message: "congradulations", preferredStyle: UIAlertControllerStyle.Alert)
               let dismissAlert: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler:{(action) in
                    self.NewGameButton.hidden = false
                })
               winAlert.addAction(dismissAlert)
               self.presentViewController(winAlert, animated: true , completion: nil)
                print("GAME WON WHOO HOO")
                return
            case .Tie:
                let tieAlert = UIAlertController(title: "Game Tie", message: "try again", preferredStyle: UIAlertControllerStyle.Alert)
                let dismissAlert: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler:{(action) in
                    self.NewGameButton.hidden = false
                    })
                tieAlert.addAction(dismissAlert)
                self.presentViewController(tieAlert, animated: true, completion: nil)
                
                print("Game tied? press newGame")
                return
            case .InProgress:
                print("game in progress")
            }
            if (OXGameController.sharedInstance.AI){
                print("in AI")
                let moveAI:Int  = OXGameController.sharedInstance.playMoveAI()
                for subview in BoardView.subviews {
                    if let button = subview as? UIButton {
                        if button.tag == moveAI{
                            button.setTitle(OXGameController.sharedInstance.getCurrentGame().whoseTurn().rawValue, forState: .Normal)
                        }
                    }
                    
                }
            
            switch OXGameController.sharedInstance.getCurrentGame().state() {
            case .Won:
                let winner = sender.titleLabel?.text
                print(winner)
                let winAlert = UIAlertController(title: "Winner is " + winner!, message: "congradulations", preferredStyle: UIAlertControllerStyle.Alert)
                let dismissAlert: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler:{(action) in
                    self.NewGameButton.hidden = false
                })
                winAlert.addAction(dismissAlert)
                self.presentViewController(winAlert, animated: true , completion: nil)
                print("GAME WON WHOO HOO")
                return
            case .Tie:
                let tieAlert = UIAlertController(title: "Game Tie", message: "try again", preferredStyle: UIAlertControllerStyle.Alert)
                let dismissAlert: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler:{(action) in
                    self.NewGameButton.hidden = false
                })
                tieAlert.addAction(dismissAlert)
                self.presentViewController(tieAlert, animated: true, completion: nil)
                
                print("Game tied? press newGame")
                return
            case .InProgress:
                print("game in progress")
            }
            }
        }
    }
}

