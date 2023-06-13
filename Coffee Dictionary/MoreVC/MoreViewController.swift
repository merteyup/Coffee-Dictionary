//
//  MoreViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 22.02.2023.
//

import UIKit
import StoreKit

class MoreViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    
    // MARK: - Functions
    
        
        func rateApp() {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "id6447113881") {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        

        
    
    
    fileprivate func shareApplication() {
#warning("Correct this with real appID")
        let url = URL(string: "https://apps.apple.com/us/app/coffeem/id6447113881")!
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        if UIDevice.current.userInterfaceIdiom == .pad{
            activityController.popoverPresentationController?.sourceView = window
            activityController.popoverPresentationController?.sourceRect = CGRect(x:  UIScreen.main.bounds.width / 4,
                                                                                  y:  UIScreen.main.bounds.height / 1.5,
                                                                                  width: UIScreen.main.bounds.width / 2,
                                                                                  height: UIScreen.main.bounds.height / 3)
        }
        window?.rootViewController!.present(activityController, animated: true)
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
            rateApp()
        } else if indexPath.row == 1 {
            if let url = URL(string: "https://docs.google.com/document/d/1p1rKGxhRknbzE30EVH0AglxpNC85INRicem33FkScYA/edit?usp=sharing") {
                UIApplication.shared.open(url)
            }
        } else if indexPath.row == 2 {
            if let url = URL(string: "https://docs.google.com/document/d/1ebVGo4uIsJtT7ICY1SB8AugbCqNJzV1attNe0NtzwqM/edit?usp=sharing") {
                UIApplication.shared.open(url)
            }
        } else if indexPath.row == 3 {
            askForNotification()
        } else if indexPath.row == 4 {
            shareApplication()
        } else if indexPath.row == 5 {
            openAvailableBadgesPage()
        }  else if indexPath.row == 6 {
            openPremiumPage(premiumPageId: 1)
        }
        
        
    }
    
    
    
}
