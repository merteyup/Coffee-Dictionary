//
//  QuizResultTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 8.04.2023.
//

import UIKit
import Lottie


protocol QuizResultTableViewCell1Delegate : AnyObject {
    func saveSolvedQuiz(isSuccess: Bool)
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

    // MARK: - Statements
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        score = 0
    }
    
    // MARK: - Functions
    func updateCell(currentQuestionArray: [Question], quizId: String, currentQuiz: Quiz) {
        for element in currentQuestionArray {
            if element.isCorrectAnswered == true {
                score += 1
                lblScore.text = "\(score) / 10"
                if score >= successScore {
                    isSuccess = true
                    lblResult.text = "Congratulations! You've earned \(currentQuiz.badge?.name ?? "new") badge."
                    quizResultTableViewCell1Delegate?.saveSolvedQuiz(isSuccess: isSuccess)
                    playLottieAnimation()
                    return
                } else {
                    lblResult.text = "Give it another try..."
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
