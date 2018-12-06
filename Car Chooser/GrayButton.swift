//
//  GrayButton.swift
//  Car Chooser
//
//  Created by Nikita Somenkov on 06/12/2018.
//  Copyright © 2018 Nikita Somenkov. All rights reserved.
//

import UIKit

class GrayButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        let stringFontName = "DIN Condensed"
        
        setTitle("Button", for: .normal)
        setTitleColor(#colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1), for: .normal)
        
        titleLabel?.font = UIFont(name: stringFontName, size: 30)
        backgroundColor = #colorLiteral(red: 0.666592598, green: 0.6667093039, blue: 0.666585207, alpha: 1)
        
        layer.cornerRadius = 8
    }
    
}
