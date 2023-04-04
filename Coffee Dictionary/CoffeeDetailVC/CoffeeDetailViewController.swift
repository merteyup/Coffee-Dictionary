//
//  CoffeeDetailViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 14.02.2023.
//

import UIKit
import RealmSwift
import GoogleMobileAds

class CoffeeDetailViewController: UIViewController, GADBannerViewDelegate {
    
    // MARK: - Variables
    var selectedCoffee : Coffee?
    var bannerView: GADBannerView!
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Statements
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBanner()
      


    }
    
    // MARK: - Functions
    
    fileprivate func loadBanner() {
        if !isVipMember {
            bannerView = GADBannerView(adSize: GADAdSizeBanner)
            bannerView.adUnitID = Constants.bannerAdId
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            bannerView.delegate = self
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
        addBannerViewToView(bannerView)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// Loads current coffee
    func loadItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - TableView Extension
extension CoffeeDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeDetailCellID") as! CoffeeDetailCell
        
        if let selectedCoffee = selectedCoffee {
            cell.updateCell(selectedCoffee: selectedCoffee)
        }
        
        return cell
        
    }
    
    
}
