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
    
    
    func updateCell(currentQuestionArray: [Question], indexPath: Int) {
        let currentQuestion = currentQuestionArray[indexPath-1]
        lblQuestionText.text = currentQuestion.questionText
        lblCorrectAnswer.text = currentQuestion.correctAnswer
        lblQuestionIndex.text = String(indexPath)
        if currentQuestion.isCorrectAnswered != nil {
            if currentQuestion.isCorrectAnswered! {
                imgResult.image = UIImage(named: "doubletick")
            } else {
                imgResult.image = UIImage(systemName: "xmark.app")
                imgResult.tintColor = UIColor.red
            }
        }
    }

}
