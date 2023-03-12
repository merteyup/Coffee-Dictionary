//
//  FirstPremiumViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 12.03.2023.
//

import UIKit

class FirstPremiumViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}


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


extension FirstPremiumViewController : FirstPremiumVcCellDelegate {
    func dismissPressed() {
        print(" FirstPremiumVcCellDelegate DismissPressed: ")
    }
    
    func productPressed(productTag: Int) {
        print(" FirstPremiumVcCellDelegate productPressed: \(productTag)")
    }
    
    func buyPressed() {
        print(" FirstPremiumVcCellDelegate buyPressed: ")
    }
    
    func privacyPressed() {
        print(" FirstPremiumVcCellDelegate privacyPressed: ")
    }
    
    func termsPressed() {
        print(" FirstPremiumVcCellDelegate termsPressed: ")

    }
    
    
    
    
    
}
