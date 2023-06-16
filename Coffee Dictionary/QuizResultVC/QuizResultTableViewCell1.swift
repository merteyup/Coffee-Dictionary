//
//  QuizResultTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 8.04.2023.
//

import UIKit
import Lottie


protocol QuizResultTableViewCell1Delegate : AnyObject {
    func saveSolvedQuiz()
}

class QuizResultTableViewCell1: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    // MARK: - Variables
    weak var quizResultTableViewCell1Delegate : QuizResultTableViewCell1Delegate?
    var score = Int()
    var isSuccess = Bool()
    var successScore = 7
    var questionCount = 10

    // MARK: - Statements
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Clear cells for reuse.
    override func prepareForReuse() {
        lblScore.text = nil
        animationView.animation = nil
    }
    
    // MARK: - Functions
    
    /// This function is responsible for quiz result operations.
    /// - Parameters:
    ///   - currentQuestionArray: Solved current questions as an array.
    ///   - currentQuiz: Current quiz from controller, for showing results.
    func updateCell(currentQuestionArray: [Question], currentQuiz: Quiz) {
        /// Filter true values in answers and keep score with that.
        let score = currentQuestionArray.filter{$0.isCorrectAnswered == true}.count
        for element in currentQuestionArray {
            if element.isCorrectAnswered == true {
                if score >= successScore {
                    lblScore.text = "\(score) / \(questionCount)"
                    isSuccess = true
                    lblResult.text = "Congratulations! You've earned \(currentQuiz.badge?.name ?? "new") badge."
                    if currentQuiz.isSolved == nil {
                        quizResultTableViewCell1Delegate?.saveSolvedQuiz()
                    }
                    playLottieAnimation()
                    return
                } else {
                    lblResult.text = "Give it another try..."
                    lblScore.text = "\(score) / \(questionCount)"
                    isSuccess = false
                    playLottieAnimation()
                }
            }
        }
    }
    
    
    
    fileprivate func playLottieAnimation() {
        if isSuccess {
            if let animation = LottieAnimation.named("success") {
                animationView.animation = animation
            }
        } else {
            if let animation = LottieAnimation.named("failure") {
                animationView.animation = animation
            }
        }
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.7
        animationView.play()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
