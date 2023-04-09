//
//  QuizResultTableViewCell3.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 8.04.2023.
//

import UIKit

protocol QuizResultTableViewCell3Delegate : AnyObject {
    func dismissPage()
}

class QuizResultTableViewCell3: UITableViewCell {
    
    
    weak var quizResultTableViewCell3Delegate : QuizResultTableViewCell3Delegate?
    
    @IBOutlet weak var btnRestartOrNext: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        btnRestartOrNext.roundedCorners(round: 10)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func actionRestartOrNext(_ sender: UIButton) {
        
        quizResultTableViewCell3Delegate?.dismissPage()
        
    }
    
}
