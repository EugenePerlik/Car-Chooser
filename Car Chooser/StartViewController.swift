//
//  ViewController.swift
//  Car Chooser
//
//  Created by Nikita Somenkov on 05/12/2018.
//  Copyright © 2018 Nikita Somenkov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var backgroudImageView: UIImageView!
    @IBOutlet weak var chooseCarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseCarButton.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.backgroudImageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        UIView.animate(withDuration: 13.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.backgroudImageView.frame = CGRect(x: 100, y: 0, width: 0, height: 0)
        }, completion: nil)
    }

    @IBAction func chooseCarButtnoTouch(_ sender: Any) {
        startGame()
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
        print(#function)
    }
    
    func startGame() {
        performSegue(withIdentifier: "startGameSegue", sender: self)
    }    
}

