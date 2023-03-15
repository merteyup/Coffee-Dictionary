//
//  TipsTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 22.02.2023.
//

import UIKit

protocol TipsTableViewCellDelegate : AnyObject {
    
    func showNextTip()
    func toggleListening(cell: TipsTableViewCell)
    
}


class TipsTableViewCell: UITableViewCell {
    
    
    // MARK: - Variables
    weak var tipsTableViewCellDelegate : TipsTableViewCellDelegate?

    // MARK: - Outlets
    @IBOutlet weak var imgTip: UIImageView!
    @IBOutlet weak var bgTip: UIView!
    @IBOutlet weak var lblTipHeader: UILabel!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var btnListenTip: UIButton!
    
    // MARK: - Statements
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgTip.image = UIImage(named: imageNamesArray[Int.random(in: 0..<imageNamesArray.count)])

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    @IBAction func nextTipPressed(_ sender: UIButton) {
        tipsTableViewCellDelegate?.showNextTip()
    }
    
    @IBAction func listenTipPressed(_ sender: UIButton) {
        tipsTableViewCellDelegate?.toggleListening(cell: self)
    }
    
}
