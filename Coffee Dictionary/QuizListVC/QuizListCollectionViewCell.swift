//
//  QuizListCollectionViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 6.04.2023.
//

import UIKit

class QuizListCollectionViewCell: UICollectionViewCell {
    
    enum QuizType {
        case brewing
        case beans
        case baristaNotes
        case ingredients
        case tools
        case recipes
    }
    
    @IBOutlet weak var lblQuizTopic: UILabel!
    @IBOutlet weak var lblQuizIndex: UILabel!
    @IBOutlet weak var bgQuiz: UIView!
    @IBOutlet weak var imgLock: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgQuiz.roundedCorners(round: 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgLock.alpha = 0
    }
    
    
    func updateCell(quizTopic: String) {
        
        
        
        getQuizTypes(type: .recipes)
        
        lblQuizTopic.text = quizTopic

    }
    
    
    func getQuizTypes(type: QuizType) {
        switch type {
        case .brewing:
            print("dislike")
        case .beans:
            print("dislike")
        case .baristaNotes:
            print("dislike")
        case .ingredients:
            print("dislike")
        case .tools:
            print("dislike")
        case .recipes:
            print("dislike")
        }
    }
  
}
