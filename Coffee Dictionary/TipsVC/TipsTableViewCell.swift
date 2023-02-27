//
//  TipsTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 22.02.2023.
//

import UIKit

protocol TipsTableViewCellDelegate : AnyObject {
    
    func showNextTip()
    
}


class TipsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgTip: UIImageView!
    @IBOutlet weak var bgTip: UIView!
    @IBOutlet weak var lblTipHeader: UILabel!
    @IBOutlet weak var lblTip: UILabel!
    weak var tipsTableViewCellDelegate : TipsTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func nextTipPressed(_ sender: UIButton) {
        tipsTableViewCellDelegate?.showNextTip()
    }
    

}
