//
//  FilterViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 19.02.2023.
//

import UIKit
import RealmSwift

protocol FilterViewControllerDelegate : AnyObject {
    
    func coffeeFiltered(filteredCoffee: String)
    
}


class FilterViewController: UIViewController {
    
    
    // MARK: - Variables
    let realm = try! Realm()
    var coffees : Results<Coffee>?
    var roastArray = [String]()
    var filterType : String?
    weak var filterViewControllerDelegate : FilterViewControllerDelegate?


    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var outsideView: UIView!
    @IBOutlet weak var headerRoast: UILabel!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        headerRoast.text = "Filter Your Coffee Type"
        dismissOnTap()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coffees = realm.objects(Coffee.self)
        
        if let coffees = coffees {
            for coffee in coffees {
                roastArray.append(coffee.roast)
            }
            let unique = Array(Set(roastArray)).filter({ $0 != ""})
            roastArray = unique
            print(unique)
            
        }
    }
    
    // MARK: - Functions
    fileprivate func dismissOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        outsideView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true)
    }

}


    // MARK: - CollectionViewDelegate
extension FilterViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roastArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterRoastCollectionViewCellID", for: indexPath) as! FilterRoastCollectionViewCell
       
        cell.lblRoast.text = roastArray[indexPath.row]
        cell.imgRoast.image = UIImage(named: roastArray[indexPath.row])
        
        return cell


    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        filterViewControllerDelegate?.coffeeFiltered(filteredCoffee: roastArray[indexPath.row])
        dismiss(animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let collectionViewWidth = collectionView.bounds.width
          return CGSize(width: collectionViewWidth/10, height: collectionViewWidth/10)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 0
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 10
      }
    
    
}
