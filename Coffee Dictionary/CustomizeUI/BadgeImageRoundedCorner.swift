//
//  BadgeImageRoundedCorner.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 12.06.2023.
//

import Foundation
import UIKit


class BadgeImageRoundedCorner : UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusAndShadow()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setRadiusAndShadow()
    }
    func setRadiusAndShadow(){
        
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 20
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
