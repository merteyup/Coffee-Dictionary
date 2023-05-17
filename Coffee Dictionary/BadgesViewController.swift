//
//  BadgesViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 5.05.2023.
//

import UIKit

class BadgesViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var imgBadge: UIImageView!
    @IBOutlet weak var lblBadge: UILabel!
    @IBOutlet var outsideView: UIView!
    
    
    var badgeTitle = String()
    var badgeName = String()
    
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.outsideView.addGestureRecognizer(tap)
        
        DispatchQueue.main.async {
            self.prepareUI()
        }

    }
    
    
    // MARK: - Functions
    
    func prepareUI() {
        lblBadge.text = badgeTitle
        imgBadge.image = UIImage(named: badgeName)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.dismiss(animated: true, completion: nil);
    }
    
  
}
