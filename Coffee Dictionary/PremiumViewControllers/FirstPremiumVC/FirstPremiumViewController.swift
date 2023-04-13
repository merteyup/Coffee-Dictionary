//
//  FirstPremiumViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 12.03.2023.
//

import UIKit
import RevenueCat

class FirstPremiumViewController: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()

        Purchases.shared.getOfferings { (offerings, error) in
            if let offerings = offerings {
                
                print("CurrentOfferings: \(offerings)")

            } else {
                print("CurrentNoOfferings:")

            }
        }
        
        Purchases.shared.getOfferings { (offerings, error) in
            if let packages = offerings?.current?.availablePackages {

                print("CurrentOfferings1: \(offerings)")

            }
        }
        
        
    }

}


    // MARK: - TableView Extension
extension FirstPremiumViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstPremiumVcCellID", for: indexPath) as! FirstPremiumVcCell
        cell.firstPremiumVcCellDelegate = self
        
        return cell
        
    }
    
    
}


    // MARK: - CellDelegateExtension
extension FirstPremiumViewController : FirstPremiumVcCellDelegate {
    func dismissPressed() {
        print(" FirstPremiumVcCellDelegate DismissPressed: ")
        dismiss(animated: true)
    }
    
    func productPressed(productTag: Int) {
        print(" FirstPremiumVcCellDelegate productPressed: \(productTag)")
#warning("Product should be selected, test in real device.")
    }
    
    func buyPressed() {
        print(" FirstPremiumVcCellDelegate buyPressed: ")
    }
    
    func privacyPressed() {
        print(" FirstPremiumVcCellDelegate privacyPressed: ")
#warning("Add privacy policy.")
    }
    
    func termsPressed() {
        print(" FirstPremiumVcCellDelegate termsPressed: ")
#warning("Add terms of usage.")
    }
    
    
    
    
    
}
