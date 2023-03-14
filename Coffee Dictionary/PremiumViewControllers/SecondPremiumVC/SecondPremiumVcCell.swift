//
//  SecondPremiumVcCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 13.03.2023.
//

import UIKit

class SecondPremiumVcCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var productView1: UIView!
    @IBOutlet weak var productView2: UIView!
    @IBOutlet weak var topViewBg: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        productView1.addProductBorder()
        
        
        if UIDevice.current.userInterfaceIdiom != .pad {
            topViewBg.addBottomRoundedEdge(desiredCurve: 1, view: topViewBg)
          //  topViewBg.makeRoundedAndShadowed(view: topViewBg)
      
        }
        
        


    }
    
    
    @IBAction func dismissPressed(_ sender: Any) {
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
