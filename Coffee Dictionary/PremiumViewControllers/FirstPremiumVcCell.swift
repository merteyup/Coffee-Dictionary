//
//  FirstPremiumVcCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 12.03.2023.
//

import UIKit

protocol FirstPremiumVcCellDelegate : AnyObject {
    
    func dismissPressed()
    func productPressed(productTag: Int)
    func buyPressed()
    func privacyPressed()
    func termsPressed()
    
}



class FirstPremiumVcCell: UITableViewCell {
    
    
    weak var firstPremiumVcCellDelegate : FirstPremiumVcCellDelegate?
    
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblInfo1: UILabel!
    @IBOutlet weak var lblInfo2: UILabel!
    @IBOutlet weak var lblInfo3: UILabel!
    
    @IBOutlet weak var lblFree1: UILabel!
    @IBOutlet weak var lblPrice1: UILabel!
    @IBOutlet weak var imgCheck1: UIImageView!
    
    @IBOutlet weak var lblFree2: UILabel!
    @IBOutlet weak var lblPrice2: UILabel!
    @IBOutlet weak var imgCheck2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func dismissPressed(_ sender: UIButton) {
        firstPremiumVcCellDelegate?.dismissPressed()
    }
    
    
    @IBAction func productPressed(_ sender: UIButton) {
        firstPremiumVcCellDelegate?.productPressed(productTag: sender.tag)
    }
    
    @IBAction func buyPressed(_ sender: UIButton) {
        firstPremiumVcCellDelegate?.buyPressed()
    }
    
    
    @IBAction func privacyPressed(_ sender: UIButton) {
        firstPremiumVcCellDelegate?.privacyPressed()
    }
    
    
    @IBAction func termsPressed(_ sender: UIButton) {
        firstPremiumVcCellDelegate?.termsPressed()
    }
    
    
    
    
}
