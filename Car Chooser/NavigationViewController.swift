//
//  NavigationViewController.swift
//  Car Chooser
//
//  Created by Nikita Somenkov on 06/12/2018.
//  Copyright © 2018 Nikita Somenkov. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ResultViewController {
            if let questionVc = topViewController as? QuestionViewController {
                vc.result = questionVc.questions?.result
            }
        }
    }


}
