//
//  ViewController.swift
//  Dicee
//
//  Created by Eduardo Velez on 6/9/19.
//  Copyright © 2019 Eduardo Velez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceArray = [ #imageLiteral(resourceName: "dice1"),#imageLiteral(resourceName: "dice2"),#imageLiteral(resourceName: "dice3"),#imageLiteral(resourceName: "dice4"),#imageLiteral(resourceName: "dice5"),#imageLiteral(resourceName: "dice6") ]

    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateDiceImages()
    }

    @IBAction func rollDiceButton(_ sender: UIButton) {
        updateDiceImages()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
    func updateDiceImages() {
             
        diceImageView1.image = diceArray[Int.random(in: 0 ... 5)]
        diceImageView2.image = diceArray[Int.random(in: 0 ... 5)]
        
    }
    
}

