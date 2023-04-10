//
//  BlogDetailViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 7.03.2023.
//

import UIKit
import GoogleMobileAds
import AVFoundation

class BlogDetailViewController: UIViewController, GADBannerViewDelegate, AVSpeechSynthesizerDelegate {
    
    // MARK: - Variables
    var selectedBlogPost = Blog()
    var bannerView: GADBannerView!
    let synthesizer = AVSpeechSynthesizer()

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()

        loadBanner()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    // MARK: - Functions
    fileprivate func loadBanner() {
        if !isVipMember {
            bannerView = GADBannerView(adSize: GADAdSizeBanner)
            bannerView.adUnitID = Constants.bannerAdId2
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
    
    fileprivate func changeButtonAppearance(_ cell: BlogDetailTableViewCell, title: String, imageName: String) {
        cell.btnListenTip.setTitle(title, for: UIControl.State.normal)
        cell.btnListenTip.setImage(UIImage(systemName: imageName), for: UIControl.State.normal)
    }
    
    func clearSynthesizerForNextUtterance() {
       do {
           try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
           try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
       } catch {
           print("audioSession properties weren't set because of an error.")
       }
   }
    
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = self.tableView.cellForRow(at: indexPath) as? BlogDetailTableViewCell {
            changeButtonAppearance(cell, title: "Listen", imageName: "speaker")
        }
        synthesizer.stopSpeaking(at: .immediate)
       }


}

    // MARK: - TableViewExtension
extension BlogDetailViewController : UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogDetailTableViewCellID", for: indexPath) as! BlogDetailTableViewCell
        cell.blogDetailTableViewCellDelegate = self
        
        cell.updateCell(blogPost: selectedBlogPost)
    
        return cell
        
    }
}

extension BlogDetailViewController : BlogDetailTableViewCellDelegate {
    
    func listenPressed(cell: BlogDetailTableViewCell) {
        if let blogPostText = cell.lblBlogPost.text {
            let utterance = AVSpeechUtterance(string: blogPostText)
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
        } else {
            #warning("Utterance couldn't created.")
        }
        
    }
    
}
