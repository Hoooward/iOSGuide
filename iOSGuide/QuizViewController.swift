//
//  QuizViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/5/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    let questions = ["From what is cognac made?",
                     "What is 7+7?",
                     "What is the capital of Vermont?"]
    let answers = ["Grapes", "14", "Montpelier"]
    
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = questions[currentQuestionIndex]
        
        for (i, string) in questions.enumerate() {
            print(" i = \(i), string = \(string)")
        }
        
    }
    
    @IBAction func showNextQuestion(sender: UIButton) {
        currentQuestionIndex++
        
        if currentQuestionIndex == answers.count {
            currentQuestionIndex = 0
        }
        questionLabel.text = questions[currentQuestionIndex]
  
    }
    
    @IBAction func showAnswer(sender: UIButton) {
        answerLabel.text = answers[currentQuestionIndex]
    }
}
