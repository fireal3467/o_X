//
//  BoardViewController.swift
//  o_X
//

import UIKit


class BoardViewController: UIViewController {
    
    
    
    @IBOutlet weak var BoardView: UIView!
    
    @IBOutlet weak var LogoutButton: UIButton!
    
    @IBOutlet weak var NewGameButton: UIButton!
    
    @IBOutlet weak var networkMessageLabel: UILabel!
    
    var networkPlay:Bool = false
    
    var player: CellType?
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        
        let cancelClosure = {(success:Bool) in
            if(success){
                print("you have successfully exited your game")
                self.dismissViewControllerAnimated(true, completion: nil)
            }else {
                print("you have failed to leave your game, keep playing or be stuck here")
            }
        }
        OXGameController.sharedInstance.cancelGame(cancelClosure)
    }
    
    //no need for button IBOutlets
    
    @IBAction func refreshGame(sender: UIBarButtonItem) {
        print("pressed refresh button")
        let refreshclosure = {(success: Bool, status: String?) in
            if(success) {
                self.updateBoard()
                // refresh the game
                print("finished refreshing")
                
    
                if(status! == "in_progress") {
                    print("status is in progress")
                    
                    if(OXGameController.sharedInstance.getCurrentGame().whoseTurn() == OXGameController.sharedInstance.player){
                        self.networkMessageLabel.text = "your turn"
                    } else {
                        self.networkMessageLabel.text = "waiting for opponent"
                    }
                } else if(status! == "abandoned"){
                    self.networkMessageLabel.text = "game abandoned"
                }
                
                
                switch OXGameController.sharedInstance.getCurrentGame().state() {
                case .Won:
                    var winner = CellType.X.rawValue
                    if(OXGameController.sharedInstance.player! == CellType.X){
                        winner = CellType.O.rawValue
                    }
                    print(winner)
                    let winAlert = UIAlertController(title: "Winner is " + winner, message: "congradulations", preferredStyle: UIAlertControllerStyle.Alert)
                    let dismissAlert: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler:{(action) in
                        if(self.networkPlay){
                            
                        } else {
                            self.NewGameButton.hidden = false
                        }
                        
                    })
                    winAlert.addAction(dismissAlert)
                    self.presentViewController(winAlert, animated: true , completion: nil)
                    print("GAME WON WHOO HOO")
                    return
                case .Tie:
                    let tieAlert = UIAlertController(title: "Game Tie", message: "try again", preferredStyle: UIAlertControllerStyle.Alert)
                    let dismissAlert: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler:{(action) in
                        
                        if(self.networkPlay){
                            
                        } else {
                            self.NewGameButton.hidden = true
                        }
                        
                    })
                    tieAlert.addAction(dismissAlert)
                    self.presentViewController(tieAlert, animated: true, completion: nil)
                    
                    print("Game tied? press newGame")
                    return
                case .InProgress:
                    print("game in progress")
                default:
                    //do nothing
                    break
                }
            } else {
                print("failed to refresh")
            }
        }
        OXGameController.sharedInstance.viewGame(refreshclosure)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(networkPlay) {
          networkMessageLabel.text = "waiting for other player"
        }else {
          NewGameButton.hidden = false
        }
        updateBoard()
        print("updated board")
        
        
    }
    
    
    
    func updateBoard() {
        print("updating boardview with the game")
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
        if(networkPlay){
            
        } else {
            NewGameButton.hidden = true
        }
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
        print("button tapped")
        if(networkPlay){
            if(OXGameController.sharedInstance.getCurrentGame().whoseTurn() != OXGameController.sharedInstance.player! ){
                print("Not your turn, you can't move")
                return
            }
        }
        if(OXGameController.sharedInstance.getCurrentGame().state() == .InProgress && sender.titleForState(.Normal)!.isEmpty) {
            sender.setTitle(OXGameController.sharedInstance.getCurrentGame().whoseTurn().rawValue, forState: .Normal)
            OXGameController.sharedInstance.playMove(Int(sender.tag) - 1 )
            print(OXGameController.sharedInstance.getCurrentGame().state().rawValue)
            switch OXGameController.sharedInstance.getCurrentGame().state() {
            case .Won:
                let winner = sender.titleLabel?.text
                print(winner)
                let winAlert = UIAlertController(title: "Winner is " + winner!, message: "congradulations", preferredStyle: UIAlertControllerStyle.Alert)
                let dismissAlert: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler:{(action) in
                    
                    if(self.networkPlay){
                    } else {
                        self.NewGameButton.hidden = false
                    }
                })
                winAlert.addAction(dismissAlert)
                self.presentViewController(winAlert, animated: true , completion: nil)
                print("GAME WON WHOO HOO")
                return
            case .Tie:
                let tieAlert = UIAlertController(title: "Game Tie", message: "try again", preferredStyle: UIAlertControllerStyle.Alert)
                let dismissAlert: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler:{(action) in
                    
                    
                    if(self.networkPlay){
                        
                    } else {
                        self.NewGameButton.hidden = false
                    }
                })
                tieAlert.addAction(dismissAlert)
                self.presentViewController(tieAlert, animated: true, completion: nil)
                
                print("Game tied? press newGame")
                return
            case .InProgress:
                print("game in progress")
            default:
                //do nothing
                break
            }
            
            if (OXGameController.sharedInstance.AI && networkPlay == false ){
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
                        if(self.networkPlay){
                            
                        } else {
                            self.NewGameButton.hidden = false
                        }
                        
                    })
                    winAlert.addAction(dismissAlert)
                    self.presentViewController(winAlert, animated: true , completion: nil)
                    print("GAME WON WHOO HOO")
                    return
                case .Tie:
                    let tieAlert = UIAlertController(title: "Game Tie", message: "try again", preferredStyle: UIAlertControllerStyle.Alert)
                    let dismissAlert: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default, handler:{(action) in
                        
                        if(self.networkPlay){
                            
                        } else {
                            self.NewGameButton.hidden = true
                        }
                        
                    })
                    tieAlert.addAction(dismissAlert)
                    self.presentViewController(tieAlert, animated: true, completion: nil)
                    
                    print("Game tied? press newGame")
                    return
                case .InProgress:
                    print("game in progress")
                default:
                    //do nothing
                    break
                }
            }
            if(networkPlay) {
                
                //send a move to the server 
                
                OXGameController.sharedInstance.playNetworkMove(sender.tag - 1)
                
            }
            
            
        }
        
        //methods outbreak
    }
}

