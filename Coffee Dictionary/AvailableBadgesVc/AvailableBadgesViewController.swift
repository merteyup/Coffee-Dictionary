//
//  AvailableBadgesViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 11.06.2023.
//

import UIKit

class AvailableBadgesViewController: UIViewController {
    
    // MARK: - Variables
    private var earnedBadgesArray : [Any]?

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAvailableBadges()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    func checkAvailableBadges() {
        if let earnedBadgesArray = Constants.saveLoad.object(forKey: "earnedBadgesArray") {
            self.earnedBadgesArray = earnedBadgesArray as! [Any]
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }

        } else {

        }
    }
 

}
    // MARK: - CollectionViewExtension

extension AvailableBadgesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let earnedBadgesArray = self.earnedBadgesArray {
            
            return earnedBadgesArray.count

        } else {
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvailableBadgesCollectionViewCellID", for: indexPath) as! AvailableBadgesCollectionViewCell
        
        
        
        return cell
    }
    
    
}
