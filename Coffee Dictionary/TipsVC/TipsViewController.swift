//
//  TipsViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 22.02.2023.
//

import UIKit
import RealmSwift
import GoogleMobileAds
import AVFoundation



class TipsViewController: UIViewController {
    
    // MARK: - Variables
    let realm = try! Realm()
    var tips : Results<Tip>?
    var currentTip = Tip()
    private var rewardedInterstitialAd: GADRewardedInterstitialAd?
    let synthesizer = AVSpeechSynthesizer()
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        synthesizer.delegate = self
        loadNewTip()
        
        loadRewardedAd()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
        synthesizer.stopSpeaking(at: .immediate)
     }
     
    
    
    
    // MARK: - Functions
    func loadNewTip () {
        tips = realm.objects(Tip.self).filter("isViewed ==[cd] %@", 0)
        if let tips = tips {
            if tips.count > 0 {
                currentTip = tips.first!
                saveTipAsViewed(currentTip: currentTip)
            } else {
#warning("This part breaks app when all tips are viewed. Should be find a solution.")
            }
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
        
        cell.lblTipHeader.text = currentTip.tip
        cell.lblTip.text = currentTip.tipDescription
        
        if synthesizer.isSpeaking != true || synthesizer.isPaused {
            if synthesizer.isSpeaking != true {
                cell.btnListenTip.setTitle("Start Listening", for: UIControl.State.normal)
            } else {
                cell.btnListenTip.setTitle("Stop Listening", for: UIControl.State.normal)
            }
        } else {
            cell.btnListenTip.setTitle("Start Listening", for: UIControl.State.normal)
        }
        
        return cell
        
    }
    
}

extension TipsViewController : TipsTableViewCellDelegate {
    func showNextTip() {
        showRewardedAd()
    }
    
    func toggleListening() {

        let utterance = AVSpeechUtterance(string: currentTip.tipDescription)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.4
        if synthesizer.isSpeaking != true || synthesizer.isPaused {
            if synthesizer.isPaused {
                synthesizer.continueSpeaking()
            } else {
                synthesizer.speak(utterance)
            }
        } else {
            synthesizer.pauseSpeaking(at: AVSpeechBoundary.word)

            // synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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


extension TipsViewController : AVSpeechSynthesizerDelegate {
  
    
}
