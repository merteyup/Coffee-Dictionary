//
//  SecondPremiumVcCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 13.03.2023.
//

import UIKit

protocol SecondPremiumVcCellDelegate : AnyObject {
    
    func dismissPressed()
    func productButtonPressed(product: Int)
    func purchaseButtonPressed()
    func termsPressed()
    func privacyPressed()
    func restorePressed()
    
}


class SecondPremiumVcCell: UITableViewCell {
    
    // MARK: - Variables
    weak var secondPremiumVcCellDelegate : SecondPremiumVcCellDelegate?
    
    
    // MARK: - Outlets
    @IBOutlet weak var productView1: UIView!
    @IBOutlet weak var productView2: UIView!
    @IBOutlet weak var topViewBg: UIView!
    @IBOutlet weak var saleView1: UIView!
    @IBOutlet weak var saleView2: UIView!
    @IBOutlet weak var btnPurchase: UIButton!
    
    // MARK: - Statements
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUi()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Functions
    fileprivate func prepareUi() {
        saleView1.addRightRoundCorners(round: 10)
        saleView2.addRightRoundCorners(round: 10)
        productView1.addProductBorder(round: 10)
        btnPurchase.roundedCorners(round: 10)
        addBtnShadow(button: btnPurchase)
        if UIDevice.current.userInterfaceIdiom != .pad {
            topViewBg.addBottomRoundedEdge(desiredCurve: 1, view: topViewBg)
        }
    }
    
    
    // MARK: - Actions
    @IBAction func dismissPressed(_ sender: UIButton) {
        secondPremiumVcCellDelegate?.dismissPressed()
    }
    
    @IBAction func productButtonPressed(_ sender: UIButton) {
        secondPremiumVcCellDelegate?.productButtonPressed(product: sender.tag)
        if sender.tag == 0 {
            productView1.addProductBorder(round: 10)
            productView2.removeProductBorder()
        } else if sender.tag == 1 {
            productView2.addProductBorder(round: 10)
            productView1.removeProductBorder()
        }
    }
    
    
    @IBAction func purchaseButtonPressed(_ sender: UIButton) {
        secondPremiumVcCellDelegate?.purchaseButtonPressed()
    }
    
    
    @IBAction func termsPressed(_ sender: UIButton) {
        secondPremiumVcCellDelegate?.termsPressed()
    }
    
    @IBAction func privacyPressed(_ sender: UIButton) {
        secondPremiumVcCellDelegate?.privacyPressed()
    }
    
    @IBAction func restorePressed(_ sender: UIButton) {
        secondPremiumVcCellDelegate?.restorePressed()
    }
    
   
}
