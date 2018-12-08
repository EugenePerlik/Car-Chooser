//
//  ResultViewController.swift
//  Car Chooser
//
//  Created by Nikita Somenkov on 06/12/2018.
//  Copyright © 2018 Nikita Somenkov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var result: Result?
    
    @IBOutlet weak var startAgainButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAgainButton.layer.cornerRadius = 8
        
        if let result = result {
            let cars = result.brands.reduce("") {
                return "\($0)\n\($1.name)"
            }
            resultLabel.text = "You should buy:\(cars)"
        } else {
            resultLabel.text = "We have not picked up anything"
        }
    }
}
