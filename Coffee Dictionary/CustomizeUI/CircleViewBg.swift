//
//  CircleViewBg.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 5.04.2023.
//

import Foundation
import UIKit


class CircleViewBg: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusAndShadow()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setRadiusAndShadow()
    }
    func setRadiusAndShadow(){
        
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
        
    }
}


