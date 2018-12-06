//
//  QuestionViewController.swift
//  Car Chooser
//
//  Created by Nikita Somenkov on 05/12/2018.
//  Copyright © 2018 Nikita Somenkov. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var questions: Questions?
    
    var tempView: UIView?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttons: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if questions == nil {
            questions = Questions()
        }

        loadQuestion()
    }

    func animateButtons() {
    
        let buttonsViews = buttons.arrangedSubviews
        let buttonsHeight: CGFloat = buttons.bounds.size.height
        
        for (index, button) in buttonsViews.enumerated() {
            button.transform = CGAffineTransform(translationX: 0, y: buttonsHeight)
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                button.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        }
        
    }
    
    func nextQuestion() {
        if questions?.nextQuestion() == nil {
            navigationController?.performSegue(withIdentifier: "result", sender: self)
            return
        }
        
        guard let newViewController = storyboard?.instantiateViewController(withIdentifier: "questionViewController") else {
            return
        }
        if let vc = newViewController as? QuestionViewController {
            vc.questions = questions
        }
        
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func backQuestion() {
        if questions?.backQuestion() == nil ||
           navigationController?.popViewController(animated: true) == nil
        {
            navigationController?.performSegue(withIdentifier: "backToStart", sender: self)
        }
    }
    
    func loadQuestion() {
        guard let question = questions?.currentQuestion else {
            return
        }
        
        questionLabel.text = question.question
        switch question.type {
        case .choose(let variants):
           loadButtons(variants: variants)
        }
    }
    
    private func loadButtons(variants: [ChooseVariant]) {
        buttons.arrangedSubviews.forEach { view in view.removeFromSuperview() }
        for variant in variants {
            let button = GrayButton()
            button.addTarget(self, action: #selector(variantChoosed(_:)),
                             for: .touchUpInside)
            button.setTitle(variant.variant, for: .normal)
            buttons.addArrangedSubview(button)
        }
    }

    @IBAction func variantChoosed(_ sender: UIButton) {
        guard let index = buttons.subviews.firstIndex(of: sender) else {
            return
        }
        
        questions?.answer(.choose(index))
        
        nextQuestion()
    }

    @IBAction func backButtonTouchUp(_ sender: Any) {
        backQuestion()
    }
}
