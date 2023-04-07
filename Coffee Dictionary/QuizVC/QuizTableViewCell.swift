//
//  QuizTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 4.04.2023.
//

import UIKit
import GradientProgressBar

protocol QuizTableViewCellDelegate : AnyObject {
    
    func answerPressed(currentQuestion: Question, selectedAnswer: String)
    
}

class QuizTableViewCell: UITableViewCell {
    
    
    // MARK: - Outlets
    @IBOutlet weak var lblQuestionText: UILabel!
    @IBOutlet weak var gradientProgressBar: GradientProgressBar!
    @IBOutlet var buttonCollection:[UIButton]!
    @IBOutlet var buttonBgCollection:[UIView]!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblCountQuestion: UILabel!
    
    
    // MARK: - Variables
    weak var quizTableViewCellDelegate : QuizTableViewCellDelegate?
    var selectedAnswer : String?
    var currentQuestion : Question?
    
    // MARK: - Statements
    override func awakeFromNib() {
        super.awakeFromNib()

        prepareUI()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
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
    
    
    // MARK: - Functions
    func buttonBgHandle() {
    }
    
    fileprivate func prepareUI() {
        gradientProgressBar.progress = 0.10
        gradientProgressBar.roundedCorners(round: 10)
        btnNext.roundedCorners(round: 10)
        
        gradientProgressBar.gradientColors = [
            .systemYellow,
            .systemGreen
        ]
    }
    
    
    func updateCell(currentQuestion: Question, questionIndex: Int) {
        lblCountQuestion.text = "\(questionIndex + 1)/10"

        self.currentQuestion = currentQuestion
        var progressIndex = Float(questionIndex + 1) * 0.1

        gradientProgressBar.setProgress(progressIndex, animated: true)
        
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
    
 
    
}
