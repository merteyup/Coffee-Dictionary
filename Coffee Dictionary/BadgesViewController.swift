//
//  BadgesViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 5.05.2023.
//

import UIKit
import Alamofire
import AlamofireImage

class BadgesViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var imgBadge: UIImageView!
    @IBOutlet weak var lblBadge: UILabel!
    @IBOutlet var outsideView: UIView!
    @IBOutlet weak var viewBg: UIView!
    
    var badge : Badge?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.prepareUI()
        }
    }
    
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.outsideView.addGestureRecognizer(tap)
        

    }
    
    // MARK: - Functions
    
    func prepareUI() {
        guard let badge = self.badge else {return}
        lblBadge.text = badge.name
        if let url = URL(string: badge.imageUrl) {
            imgBadge.af.setImage(withURL: url)
            UIView.animate(withDuration: 0.5) {
                self.imgBadge.alpha = 1
                self.viewBg.alpha = 1
            }
        }
        
       

        imgBadge.layer.cornerRadius = 10
        imgBadge.clipsToBounds = true
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.dismiss(animated: true, completion: nil);
    }
    
  
}
