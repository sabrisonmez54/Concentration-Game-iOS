//
//  WelcomeScreenViewController.swift
//  Concentration
//
//  Created by Sabri Sönmez on 9/19/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import UIKit
import Lottie
class WelcomeScreenViewController: UIViewController
{
    @IBOutlet var controlView: UIView!
    @IBOutlet weak var startNewGame: UIButton!
    
    @IBOutlet weak var changeThemeButton: UIButton!
    @IBOutlet weak var animationView: LOTAnimatedControl!
    
    var halloweenTheme = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        playAnimation(animationName: "3124-halloween-smoothymon")
        // Do any additional setup after loading the view.
    }
    
    func playAnimation(animationName: String)
    {
        animationView.animationView.setAnimation(named: "\(animationName)")
        animationView.animationView.loopAnimation = true
        animationView.animationView.play()
    }
    @IBAction func changeThemeClicked(_ sender: Any) {
        if halloweenTheme == true
        {
            changeThemeButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            changeThemeButton.setTitleColor(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), for: .normal)
            startNewGame.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            startNewGame.setTitleColor(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), for: .normal)
            controlView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            playAnimation(animationName: "9579-delivery")
            halloweenTheme = false
           
        }
        else
        {
            changeThemeButton.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            changeThemeButton.setTitleColor(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1), for: .normal)
            startNewGame.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            startNewGame.setTitleColor(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1), for: .normal)
            controlView.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            playAnimation(animationName: "3124-halloween-smoothymon")
            halloweenTheme = true
        }
    }
    
    @IBAction func startNewGameClicked(_ sender: Any)
    {
        self.performSegue(withIdentifier: "WelcomeScreenToGame", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "WelcomeScreenToGame")
        {
            let gameVC = segue.destination as! ViewController
            if halloweenTheme == true
            {
                 gameVC.emojiChoices = ["👻","🎃","☠️","👹","🍎","🧟‍♂️","🍬","🍫","🍭"]
                 gameVC.halloweenTheme = true
            }
            else
            {
                 gameVC.emojiChoices = ["🎾","⚽️","🏀","⛷","🏊‍♀️","🏈","🚴🏻‍♂️","⚾️","🥊"]
                 gameVC.halloweenTheme = false
            }
        }
    }
}
