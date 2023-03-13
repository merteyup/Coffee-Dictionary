//
//  FirstPremiumVcCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 12.03.2023.
//

import UIKit
import Lottie

protocol FirstPremiumVcCellDelegate : AnyObject {
    
    func dismissPressed()
    func productPressed(productTag: Int)
    func buyPressed()
    func privacyPressed()
    func termsPressed()
    
}



class FirstPremiumVcCell: UITableViewCell {
    
    
    weak var firstPremiumVcCellDelegate : FirstPremiumVcCellDelegate?
    
    
    
    @IBOutlet weak var animationView: LottieAnimationView!
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
    
    @IBOutlet weak var productView1: UIView!
    @IBOutlet weak var productView2: UIView!
    @IBOutlet weak var btnFreeTrial: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productView1.addProductBorder()
        btnFreeTrial.roundedCorners(round: 10)
        btnFreeTrial.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btnFreeTrial.layer.shadowOffset = CGSize(width: -1.0, height: 4.0)
        btnFreeTrial.layer.shadowOpacity = 0.8
        btnFreeTrial.layer.shadowRadius = 0.5
        btnFreeTrial.layer.masksToBounds = false
        btnFreeTrial.layer.cornerRadius = 4.0


        playLottieAnimation()
        updateCell()
    }
    
    func updateCell() {
        var lblInfos = [lblInfo1, lblInfo2, lblInfo3]
        for (index, info) in lblInfos.enumerated() {
            info?.text = paywallInfos[index]
        }
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
        
        if sender.tag == 0 {
            productView1.addProductBorder()
            productView2.removeProductBorder()
            imgCheck1.alpha = 1
            imgCheck2.alpha = 0
        } else if sender.tag == 1 {
            productView2.addProductBorder()
            productView1.removeProductBorder()
            imgCheck1.alpha = 0
            imgCheck2.alpha = 1
        }
        
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
    
    
    
    fileprivate func playLottieAnimation() {
        // 1. Set animation content mode
        animationView.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        animationView.loopMode = .loop
        // 3. Adjust animation speed
        animationView.animationSpeed = 0.7
        // 4. Play animation
        animationView.play()
    }
    
}


