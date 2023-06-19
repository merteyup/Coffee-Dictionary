//
//  AvailableBadgesViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 11.06.2023.
//

import UIKit

class AvailableBadgesViewController: UIViewController {
    
    // MARK: - Variables
    private var availableBadges : [Badge]?

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.availableBadges = self.checkAvailableBadges()
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
     

    }
    
    // MARK: - Functions
    func checkAvailableBadges() -> [Badge]? {
     
       let availableBadges = Badge.fetchCurrentBadges(currentQuizzes: nil,
                                 isForSingleBadge: false)
        
        return availableBadges

    }
 

}
    // MARK: - CollectionViewExtension

extension AvailableBadgesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let availableBadges = availableBadges {
            
            return availableBadges.count

        } else {
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvailableBadgesCollectionViewCellID", for: indexPath) as! AvailableBadgesCollectionViewCell
        
        if let availableBadges = availableBadges {
            cell.lblBadge.text = availableBadges[indexPath.row].name
            cell.lblBadgeSubText.text = availableBadges[indexPath.row].subText
            if let url = URL(string: availableBadges[indexPath.row].imageUrl) {
                cell.imgBadge.af.setImage(withURL: url)
            }
        }
        
        return cell
    }
    
    // Distance Between Item Cells
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 20
     }
     
     // Cell Margin
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
     }
    
    
}

