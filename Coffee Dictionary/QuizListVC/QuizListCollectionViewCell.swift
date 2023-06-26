//
//  QuizListCollectionViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 6.04.2023.
//

import UIKit

class QuizListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblQuizTopic: UILabel!
    @IBOutlet weak var lblQuizIndex: UILabel!
    @IBOutlet weak var bgQuiz: UIView!
    @IBOutlet weak var imgLock: UIImageView!
    @IBOutlet weak var imgBadge: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgQuiz.roundedCorners(round: 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgLock.alpha = 0
    }
    
    
    func updateCell(currentQuiz: Quiz, indexPath: Int) {
        
        lblQuizTopic.text = currentQuiz.quizTopic
        
        if let badge = currentQuiz.badge {
            lblQuizIndex.text = "Game \(indexPath + 1): \(badge.name)"
        } else {
            lblQuizIndex.text = "Game \(indexPath + 1):"
        }
        
        if let image = currentQuiz.badge?.imageUrl {
            if let url = URL(string: image) {
                imgBadge.af.setImage(withURL: url)
            }
        }

    }
    
    
   
  
}
