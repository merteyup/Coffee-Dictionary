//
//  FilterBg.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 21.02.2023.
//

import Foundation
import UIKit

class FilterBg: UIView {

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
        layer.cornerRadius = 10
        layer.shadowRadius = 0.5
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
    }
}
