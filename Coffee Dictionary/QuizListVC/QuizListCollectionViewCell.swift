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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgQuiz.roundedCorners(round: 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgLock.alpha = 0
    }
    
  
}
