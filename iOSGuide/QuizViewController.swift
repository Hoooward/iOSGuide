//
//  QuizViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/5/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var nextQuestionLabel: UILabel!
    

    
    @IBOutlet weak var nextQuestionlabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    let questions = ["From what is cognac made?",
                     "What is 7+7?",
                     "What is the capital of Vermont?"]
    let answers = ["Grapes", "14", "Montpelier"]
    
    var currentQuestionIndex: Int = 0
    
    
    enum AnimationStatus {
        case Animating
        case Done
    }
    
    private var Status: AnimationStatus = .Done
    
    // MARK: View life cacly
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the label's initial alpha
        nextQuestionLabel.alpha = 1
        currentQuestionLabel.alpha = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        for (i, string) in questions.enumerate() {
            print(" i = \(i), string = \(string)")
        }
        
        updateOffScreenLabel()
        
//        let space = UILayoutGuide()
//        
//        
//        view.addLayoutGuide(space)
//        
//        NSLayoutConstraint(
//            item: space,
//            attribute: .Width,
//            relatedBy: .Equal,
//            toItem: view,
//            attribute: .Width,
//            multiplier: 1.0,
//            constant: view.frame.width).active = true
//        
//        nextQuestionLabel.trailingAnchor.constraintEqualToAnchor(space.leadingAnchor).active = true
//        
//        currentQuestionLabel.leadingAnchor.constraintEqualToAnchor(space.trailingAnchor).active = true
//        
//        
//        
//        view.layoutIfNeeded()
        
        print("current.frame = \(currentQuestionLabel.frame)")
        print("next.frame = \(nextQuestionLabel.frame)")
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionlabelCenterXConstraint.constant = -screenWidth
    }
    
    @IBAction func showNextQuestion(sender: UIButton) {
        
        switch Status {
            
        case .Done:
            currentQuestionIndex++
            
            if currentQuestionIndex == answers.count {
                currentQuestionIndex = 0
            }
            nextQuestionLabel.text = questions[currentQuestionIndex]
            
            answerLabel.text = "???"
            
            animateLabelTransitions()
        case .Animating:
            return
        }
        
     
  
    }
    
    @IBAction func showAnswer(sender: UIButton) {
        answerLabel.text = answers[currentQuestionIndex]
    }
    
    // MARK: Animate 
    func  animateLabelTransitions() {
        
        // Force any outstanding layout changes to occur
        view.layoutIfNeeded()
        
        // Animate the alpha
        // and the center X constranints
        let screenWidth = view.frame.width
        self.nextQuestionlabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        
//        UIView.animateWithDuration(
//            0.5,
//            delay: 0,
//            options: [.CurveLinear],
//            animations: {
//
//
//            
//            }, completion: { _ in
//              
//        })
//        
        print("current.frame = \(currentQuestionLabel.frame)")
        print("next.frame = \(nextQuestionLabel.frame)")
        
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: [],
            animations: {
                switch self.Status {
                case .Done:
                    self.Status = .Animating
                    self.currentQuestionLabel.alpha = 1
                    self.nextQuestionLabel.alpha = 1
                    self.view.layoutIfNeeded()
                    
                default: break
                }
              
            }, completion: { finish in
                
                if finish {
                    swap(&self.currentQuestionLabel,
                        &self.nextQuestionLabel)
                    swap(&self.nextQuestionlabelCenterXConstraint,
                        &self.currentQuestionLabelCenterXConstraint)
                    self.updateOffScreenLabel()
                    self.Status = .Done
                }
            
        })
    }
    
    
    
}











