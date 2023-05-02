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



class TipsViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
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
        synthesizer.stopSpeaking(at: .immediate)
        tips = realm.objects(Tip.self).filter("isViewed ==[cd] %@", 0)
        if let currentTips = tips {
            if currentTips.count > 0 {
                currentTip = currentTips.first!
                saveTipAsViewed(currentTip: currentTip)
            } else {
        tips = realm.objects(Tip.self).filter("isViewed ==[cd] %@", 1)
                if let emptyTips = tips {
                    for tip in emptyTips {
                        clearTipViewHistory(tip: tip)
                        currentTip = emptyTips.first!
                    }
                }
            }
        } 
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func clearTipViewHistory(tip: Tip) {
        do {
            try realm.write {
                tip.isViewed = 0
            }
        } catch {
            print(error)
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
        GADRewardedInterstitialAd.load(withAdUnitID: Constants.rewardedAdId,
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
            self.loadNewTip()
            return print("Ad wasn't ready.")
        }
        
        rewardedInterstitialAd.present(fromRootViewController: self) {
            let reward = rewardedInterstitialAd.adReward
            self.loadNewTip()
            self.loadRewardedAd()
        }
    }
    
    fileprivate func changeButtonAppearance(_ cell: TipsTableViewCell, title: String, imageName: String) {
        cell.btnListenTip.setTitle(title, for: UIControl.State.normal)
        cell.btnListenTip.setImage(UIImage(systemName: imageName), for: UIControl.State.normal)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = self.tableView.cellForRow(at: indexPath) as? TipsTableViewCell {
            changeButtonAppearance(cell, title: "Listen", imageName: "speaker")
        }
        synthesizer.stopSpeaking(at: .immediate)
        if !isVipMember {
            showRewardedAd()
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
        
        return cell
        
    }
    
}
    // MARK: - CellDelegateExtension
extension TipsViewController : TipsTableViewCellDelegate {
    func showNextTip() {
        if !isVipMember {
            showRewardedAd()
        } else {
            loadNewTip()
        }
    }
    
    func toggleListening(cell: TipsTableViewCell) {
        
                
        let utterance = AVSpeechUtterance(string: currentTip.tipDescription)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.45
        if synthesizer.isSpeaking != true || synthesizer.isPaused {
            changeButtonAppearance(cell, title: "Stop", imageName: "speaker.slash")
            if synthesizer.isPaused {
                synthesizer.continueSpeaking()
            } else {
                clearSynthesizerForNextUtterance()
                synthesizer.speak(utterance)
            }
        } else {
            changeButtonAppearance(cell, title: "Listen", imageName: "speaker")
            synthesizer.pauseSpeaking(at: AVSpeechBoundary.word)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate func clearSynthesizerForNextUtterance() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
    }
}

    // MARK: - Interstitial Extension
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

