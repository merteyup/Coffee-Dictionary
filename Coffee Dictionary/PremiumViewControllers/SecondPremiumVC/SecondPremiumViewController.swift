//
//  SecondPremiumViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 13.03.2023.
//

import UIKit

class SecondPremiumViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
}


// MARK: - TableViewExtension
extension SecondPremiumViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondPremiumVcCellID", for: indexPath) as! SecondPremiumVcCell
        cell.secondPremiumVcCellDelegate = self
        
        return cell
    }
    
}


// MARK: - CellDelegateExtension
extension SecondPremiumViewController : SecondPremiumVcCellDelegate {
    func dismissPressed() {
        dismiss(animated: true)
    }
    
    func productButtonPressed(product: Int) {
    
    }
    
    func purchaseButtonPressed() {
        
    }
    
    func termsPressed() {
        
    }
    
    func privacyPressed() {
        
    }
    
    func restorePressed() {
        
    }
    
    
    
}
