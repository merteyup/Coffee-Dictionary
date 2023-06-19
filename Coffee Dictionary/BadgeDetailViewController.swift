//
//  BadgeDetailViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 19.06.2023.
//

import UIKit

class BadgeDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblBadgeName: UILabel!
    @IBOutlet weak var imgBadge: UIImageView!
    @IBOutlet weak var lblBadgeSubText: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    
    // MARK: - Variables
    
    var currentBadge : Badge?
    
    // MARK: - Statements
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.prepareUI(currentBadge: self.currentBadge)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Actions
    @IBAction func shareBadgePressed(_ sender: Any) {
        self.btnShare.isHidden = true

        DispatchQueue.main.async {
            let bounds = UIScreen.main.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
            self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.btnShare.isHidden = false
            let activityViewController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
        
        
    }
    
    
    // MARK: - Functions
    func prepareUI (currentBadge: Badge?) {
        if let currentBadge = currentBadge {
            lblBadgeName.text = currentBadge.name
            lblBadgeSubText.text = currentBadge.subText
            if let url = URL(string: currentBadge.imageUrl) {
                imgBadge.af.setImage(withURL: url)
            }
        }
    }
    
}
