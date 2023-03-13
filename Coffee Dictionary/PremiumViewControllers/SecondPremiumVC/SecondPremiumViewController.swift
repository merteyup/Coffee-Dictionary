//
//  SecondPremiumViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 13.03.2023.
//

import UIKit

class SecondPremiumViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 
}


extension SecondPremiumViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondPremiumVcCellID", for: indexPath) as! SecondPremiumVcCell
        
        
        return cell
    }
    
    
    
    
}
