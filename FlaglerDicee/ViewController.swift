//
//  ViewController.swift
//  Flagler Dicee
//
// The enhancements are the new abilities of the Unroll button to hide when not usable, the background music and the roll sound effect, and the animated logo

import UIKit
//Import audio kit
import AVFoundation

class ViewController: UIViewController {
    
    //setup audio
    var backgroundAudioPlayer: AVAudioPlayer?
    var diceAudioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var diceeLogoView: UIImageView!
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var unrollButtonUI: UIButton!
    
    var leftDiceNumber = 0
    var rightDiceNumber = 5
    var previousLeftDiceNumber = 0
    var previousRightDiceNumber = 0
    var diceArray = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        unrollButtonUI.isHidden = true
        
        //play background music
        if let url = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") {
            backgroundAudioPlayer = try? AVAudioPlayer(contentsOf: url)
            backgroundAudioPlayer?.numberOfLoops = -1
            backgroundAudioPlayer?.play()
        }
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        //Controls the storage for the unroll function
        previousLeftDiceNumber = leftDiceNumber
        previousRightDiceNumber = rightDiceNumber
        unrollButtonUI.isHidden = false
        
        leftDiceNumber = Int.random(in: 0...5)
        rightDiceNumber = Int.random(in: 0...5)
        
        // let _____ #imageLiteral(
        diceImageView1.image = diceArray[leftDiceNumber]
        diceImageView2.image = diceArray[rightDiceNumber]
        
        PlaySound()
        AnimateLogo()
        
    }
    
    @IBAction func unrollButtonPressed(_ sender: UIButton) {
        
        diceImageView1.image = diceArray[previousLeftDiceNumber]
        diceImageView2.image = diceArray[previousRightDiceNumber]
        sender.isHidden = true
        
        PlaySound()
        AnimateLogo()
        
    }
    
    @IBAction func snakeButtonPressed(_ sender: UIButton) {
        
        leftDiceNumber = 0
        rightDiceNumber = 0
        
        diceImageView1.image = diceArray[leftDiceNumber]
        diceImageView2.image = diceArray[rightDiceNumber]
        
        PlaySound( )
        AnimateLogo()
    }
    
    //Create reusable function to play dice sounds
    public func PlaySound() {
        
        if let url = Bundle.main.url(forResource: "diceThrow", withExtension: "mp3") {
            diceAudioPlayer = try? AVAudioPlayer(contentsOf: url)
            diceAudioPlayer?.play()
        }
    }
    
    
    //Waits work synchronously not sequentially
    public func AnimateLogo() {
        diceeLogoView.image = #imageLiteral(resourceName: "diceeLogoEmptyFrame")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.diceeLogoView.image = #imageLiteral(resourceName: "DiceeLogo")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.diceeLogoView.image = #imageLiteral(resourceName: "diceeLogoEmptyFrame")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.diceeLogoView.image = #imageLiteral(resourceName: "DiceeLogo")
        }
    }
    
}
