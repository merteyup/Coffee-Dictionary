//
//  QuizTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 4.04.2023.
//

import UIKit

protocol QuizTableViewCellDelegate : AnyObject {
    
    func answerPressed(currentQuestion: Question, selectedAnswer: String)
    
}

class QuizTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblQuestionText: UILabel!
  
    
    @IBOutlet var buttonCollection:[UIButton]!
    @IBOutlet var buttonBgCollection:[UIView]!

    
    weak var quizTableViewCellDelegate : QuizTableViewCellDelegate?
    var selectedAnswer : String?
    var currentQuestion : Question?
    
    override func awakeFromNib() {
        super.awakeFromNib()


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func buttonBgHandle() {
    }
    
    func updateCell(currentQuestion: Question) {

        self.currentQuestion = currentQuestion
        
        if let currentQuestionText = currentQuestion.questionText {
            lblQuestionText.text = currentQuestionText
        }

        if let currentQuestionAnswers = currentQuestion.answers {
            for (index, answer) in buttonCollection.enumerated() {
                answer.setTitle(currentQuestionAnswers[index], for: UIControl.State.normal)
            }
        }
       
        
    }
    
    
    fileprivate func resetColors() {
        for element in buttonBgCollection {
            element.backgroundColor = UIColor(named: "appBackgroundColor")
        }
        for button in buttonCollection {
            button.tintColor = UIColor(named: "appMainColor")
        }
    }
    
    @IBAction func selectionPressed(_ sender: UIButton) {
        selectedAnswer = sender.titleLabel?.text
        
        resetColors()
        
        buttonBgCollection[sender.tag].backgroundColor = .systemYellow
       
        
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {

        if currentQuestion != nil {
            resetColors()
            currentQuestion!.isAnswered = true
            if let selectedAnswer = selectedAnswer {
                quizTableViewCellDelegate?.answerPressed(currentQuestion: currentQuestion!, selectedAnswer: selectedAnswer)
                self.selectedAnswer = nil
            } else {
                print("Select answer please")
            }
        }
    }
    
}
