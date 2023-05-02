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
    
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblResult: UILabel!
    
    weak var quizResultTableViewCell1Delegate : QuizResultTableViewCell1Delegate?
    var score = Int()
    var isSuccess = Bool()
    


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        score = 0
    }
    
    func updateCell(currentQuestionArray: [Question], quizId: String) {
        
        for element in currentQuestionArray {
            if element.isCorrectAnswered == true {
                score += 1
                lblScore.text = "\(score) / 10"
                if score >= 7 {
                    isSuccess = true
                    lblResult.text = "Congratulations!"
                    /// For now keep only successful results.
                  
                } else {
                    lblResult.text = "Give it another try..."
                    isSuccess = false
                }
               
                playLottieAnimation()
            }
        }
        if isSuccess {
            quizResultTableViewCell1Delegate?.saveSolvedQuiz(isSuccess: isSuccess)
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
