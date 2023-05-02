//
//  QuizResultViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 8.04.2023.
//

import UIKit
import GoogleMobileAds

class QuizResultViewController: UIViewController {
    
    // MARK: - Variables
    var currentQuestionsArray = [Question]()
    var quizId = String()
    private var interstitial: GADInterstitialAd?
    var resultData = [[String: Any]]()

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: Constants.interstitialAdId,
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
        )
        
    }
    
    
    // MARK: - Functions
    func showInterstitial() {
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
        } else {
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension QuizResultViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Added 2 for extra cells in table except questions.
        return currentQuestionsArray.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizResultTableViewCell1ID", for: indexPath) as! QuizResultTableViewCell1
            cell.quizResultTableViewCell1Delegate = self
            cell.updateCell(currentQuestionArray: currentQuestionsArray, quizId: quizId)
            return cell
        } else if indexPath.row > 0 && indexPath.row <= 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizResultTableViewCell2ID", for: indexPath) as! QuizResultTableViewCell2
            cell.updateCell(currentQuestionArray: currentQuestionsArray, indexPath: indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizResultTableViewCell3ID", for: indexPath) as! QuizResultTableViewCell3
            cell.quizResultTableViewCell3Delegate = self
            return cell
        }
    }
}

extension QuizResultViewController : QuizResultTableViewCell1Delegate {
    func saveSolvedQuiz(isSuccess: Bool) {
        let result = ["quizId" : quizId, "result" : isSuccess] as [String : Any]
        resultData.append(result)
        Constants.saveLoad.set(resultData, forKey: "earnedBadgesArray")
    }
   
}

extension QuizResultViewController : QuizResultTableViewCell3Delegate {
    
    func dismissPage() {
        if !isVipMember {
            showInterstitial()
        } else {
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension QuizResultViewController : GADFullScreenContentDelegate {
    
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
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
