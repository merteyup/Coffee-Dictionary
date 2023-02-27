//
//  TipsViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 22.02.2023.
//

import UIKit
import RealmSwift
import GoogleMobileAds


class TipsViewController: UIViewController {
    
    // MARK: - Variables
    let realm = try! Realm()
    var tips : Results<Tip>?
    var currentTip = Tip()
    private var rewardedInterstitialAd: GADRewardedInterstitialAd?
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewTip()
        
        loadRewardedAd()
        
    }
    
    
    
    
    // MARK: - Functions
    func loadNewTip () {
        tips = realm.objects(Tip.self).filter("isViewed ==[cd] %@", 0)
        if let tips = tips {
            currentTip = tips.first!
            saveTipAsViewed(currentTip: currentTip)
        } else {
#warning("Tip couldn't found.")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func saveTipAsViewed(currentTip: Tip) {
        do {
            try realm.write {
                if currentTip.isViewed == 0 {
                    currentTip.isViewed = 1
                }
            }
        } catch {
            print(error)
        }
    }
    fileprivate func loadRewardedAd() {
        GADRewardedInterstitialAd.load(withAdUnitID: Constants.rewardedAdTestId,
                                       request: GADRequest()) { ad, error in
            if let error = error {
                return print("Failed to load rewarded interstitial ad with error: \(error.localizedDescription)")
            }
            
            self.rewardedInterstitialAd = ad
            self.rewardedInterstitialAd?.fullScreenContentDelegate = self
        }
    }
    
    func showRewardedAd() {
        guard let rewardedInterstitialAd = rewardedInterstitialAd else {
            return print("Ad wasn't ready.")
        }
        
        rewardedInterstitialAd.present(fromRootViewController: self) {
            let reward = rewardedInterstitialAd.adReward
            self.loadNewTip()
            self.loadRewardedAd()
        }
    }
    
    
}

// MARK: - TableViewExtension
extension TipsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipsTableViewCellID", for: indexPath) as! TipsTableViewCell
        cell.tipsTableViewCellDelegate = self
        
        cell.imgTip.image = UIImage(named: imageNamesArray[Int.random(in: 0..<imageNamesArray.count)])
        cell.lblTipHeader.text = currentTip.tip
        cell.lblTip.text = currentTip.tipDescription
        
        return cell
        
    }
    
}

extension TipsViewController : TipsTableViewCellDelegate {
    func showNextTip() {
        showRewardedAd()
    }
}

extension TipsViewController: GADFullScreenContentDelegate {
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
    }
}
