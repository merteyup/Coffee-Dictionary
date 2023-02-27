//
//  MoreViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 22.02.2023.
//

import UIKit

class MoreViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Functions
    fileprivate func shareApplication() {
#warning("Correct this with real appID")
        let url = URL(string: "https://apps.apple.com/us/app/xxxxxxxxx")!
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(vc, animated: true)
    }
    
    fileprivate func askForNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification Error: \(error)")
            }
            if granted {
                let alertbox = UIAlertController(title: "Oopss...", message: "Notification permission already granted", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "Thanks", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                }
                alertbox.addAction(okAction)
                DispatchQueue.main.async {
                    self.present(alertbox, animated: true, completion: nil)
                    
                }
                print("Notification granted")
            } else {
                
            }
            
        }
    }

}


// MARK: - TableViewExtension
extension MoreViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCellID", for: indexPath) as! MoreTableViewCell
        
        cell.lblMore.text = moreMenuItems[indexPath.row]
        cell.imgMore.image = UIImage(systemName: moreMenuImages[indexPath.row])
        
        return cell
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        } else if indexPath.row == 1 {
            
        } else if indexPath.row == 2 {
            
        } else if indexPath.row == 3 {
            askForNotification()
            
        } else if indexPath.row == 4 {
            shareApplication()
        }
        
        
    }
    
    
    
}
