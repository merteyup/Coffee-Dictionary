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
    func restorePressed()

    
}



class FirstPremiumVcCell: UITableViewCell {
    
    
    // MARK: - Variables
    weak var firstPremiumVcCellDelegate : FirstPremiumVcCellDelegate?
    
    
    // MARK: - Outlets
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblInfo1: UILabel!
    @IBOutlet weak var lblInfo2: UILabel!
    @IBOutlet weak var lblInfo3: UILabel!
    @IBOutlet weak var lblInfo4: UILabel!
    
    @IBOutlet weak var lblFree1: UILabel!
    @IBOutlet weak var lblPrice1: UILabel!
    @IBOutlet weak var imgCheck1: UIImageView!
    
    @IBOutlet weak var lblFree2: UILabel!
    @IBOutlet weak var lblPrice2: UILabel!
    @IBOutlet weak var imgCheck2: UIImageView!
    
    @IBOutlet weak var productView1: UIView!
    @IBOutlet weak var productView2: UIView!
    @IBOutlet weak var btnFreeTrial: UIButton!
    
    
  // MARK: - Statements
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()

        playLottieAnimation()
        updateCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Function
    func updateCell() {
        var lblInfos = [lblInfo1, lblInfo2, lblInfo3, lblInfo4]
        for (index, info) in lblInfos.enumerated() {
            info?.text = paywallInfos[index]
        }
    }
    
    fileprivate func prepareUI() {
        // Initialization code
        productView1.addProductBorder(round: 10)
        addBtnShadow(button: btnFreeTrial)
        productView2.addProductBorder(round: 10)
        productView1.removeProductBorder()
        imgCheck1.alpha = 0
        imgCheck2.alpha = 1
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

    // MARK: - Actions
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
    
    
    @IBAction func restorePressed(_ sender: Any) {
        firstPremiumVcCellDelegate?.restorePressed()
    }
    
}


