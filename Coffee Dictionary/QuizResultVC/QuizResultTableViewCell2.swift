//
//  QuizResultTableViewCell2.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 8.04.2023.
//

import UIKit

class QuizResultTableViewCell2: UITableViewCell {
    
    
    @IBOutlet weak var lblQuestionText: UILabel!
    @IBOutlet weak var lblCorrectAnswer: UILabel!
    @IBOutlet weak var lblQuestionIndex: UILabel!
    @IBOutlet weak var imgResult: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblQuestionText.text = nil
        lblCorrectAnswer.text = nil
        lblQuestionIndex.text = nil
        imgResult.image = nil
    }
    
    
    func updateCell(currentQuestionArray: [Question], indexPath: Int) {
        let currentQuestion = currentQuestionArray[indexPath-1]
        lblQuestionText.text = currentQuestion.questionText
        lblCorrectAnswer.text = currentQuestion.correctAnswer
        lblQuestionIndex.text = String(indexPath)
        if currentQuestion.isCorrectAnswered != nil {
            if currentQuestion.isCorrectAnswered! {
                if self.traitCollection.userInterfaceStyle == .dark {
                    imgResult.image = UIImage(systemName: "checkmark")
                } else {
                    imgResult.image = UIImage(named: "doubletick")
                }
                
            } else {
                imgResult.image = UIImage(systemName: "xmark")
                imgResult.tintColor = UIColor.red
            }
        }
    }

}
