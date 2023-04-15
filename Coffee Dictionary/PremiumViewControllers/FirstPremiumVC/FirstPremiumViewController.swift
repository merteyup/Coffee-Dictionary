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
    var offering: Offering?
    var package : Package?

    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getOfferings()

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    fileprivate func getOfferings() {
        Purchases.shared.getOfferings { (offerings, error) in
            if let offerings = offerings {
                self.offering = offerings.current
                /// For now here's only one package available.
                if let package = self.offering?.availablePackages.first {
                    self.package = package
                    self.tableView.reloadData()
                }
            } else {
                print("Offerings Error: \(error?.localizedDescription)")
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
        /// Set price in current currency.
        if let price = self.package?.localizedPriceString {
            cell.lblPrice2.text = "Only: \(price)"
        }
        return cell
    }
}


    // MARK: - CellDelegateExtension
extension FirstPremiumViewController : FirstPremiumVcCellDelegate {
    func dismissPressed() {
        dismiss(animated: true)
    }
    
    /// Left in here for future product implementations.
    func productPressed(productTag: Int) {
    }
    
    func buyPressed() {
        /// - Find the package being selected, and purchase it
        if let package = package {
            Purchases.shared.purchase(package: package) { (transaction, purchaserInfo, error, userCancelled) in
                if let error = error {
                    let alertbox = UIAlertController(title: "Oopss...", message: "\(error.localizedDescription) Please try again.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                    }
                    alertbox.addAction(okAction)
                } else {
                    /// - If the entitlement is active after the purchase completed, dismiss the paywall
                    if purchaserInfo?.entitlements[Constants.entitlementId]?.isActive == true {
                        print("Purchase Completed: \(isVipMember)")
                        /// Set user as premium and send notification to pages for refresh values.
                        isVipMember = true
                        NotificationCenter.default.post(name: Notification.Name("purchaseCompleted"), object: nil)
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    func privacyPressed() {
        if let url = URL(string: "https://docs.google.com/document/d/1p1rKGxhRknbzE30EVH0AglxpNC85INRicem33FkScYA/edit?usp=sharing") {
            UIApplication.shared.open(url)
        }
    }
    
    func termsPressed() {
        if let url = URL(string: "https://docs.google.com/document/d/1ebVGo4uIsJtT7ICY1SB8AugbCqNJzV1attNe0NtzwqM/edit?usp=sharing") {
            UIApplication.shared.open(url)
        }
    }
    
    func restorePressed() {
        Purchases.shared.restorePurchases { (customerInfo, error) in
            if customerInfo?.entitlements[Constants.entitlementId]?.isActive == true {
                isVipMember = true
                let alertbox = UIAlertController(title: "Thanks", message: "Your premium access granted again", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
                alertbox.addAction(okAction)
                DispatchQueue.main.async {
                    self.present(alertbox, animated: true, completion: nil)
                    
                }
            }
        }
    }
}
