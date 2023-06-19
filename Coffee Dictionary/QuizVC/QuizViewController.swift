//
//  QuizViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 4.04.2023.
//

import UIKit
import GoogleMobileAds


class QuizViewController: UIViewController {
    
    // MARK: - Variables
    var currentQuestionsArray = [Question]()
    var currentQuiz = Quiz(singleQuiz: nil, id: nil, isSolved: nil, quizTopic: nil, badge: nil)
    var bannerView: GADBannerView!

    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBanner()
    }
    
}



extension QuizViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCellID", for: indexPath) as! QuizTableViewCell
        cell.quizTableViewCellDelegate = self
        if let index = currentQuestionsArray.firstIndex(where: { $0.isAnswered == nil}){
            cell.updateCell(currentQuestion: currentQuestionsArray[index], questionIndex: index)
        }
        return cell
        
    }
    
}

extension QuizViewController : QuizTableViewCellDelegate {
    
    func answerPressed(currentQuestion: Question, selectedAnswer: String) {
        answeredOperations(currentQuestion, selectedAnswer)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func dismissPage() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    /// Description This works for answered questions. Set value of object as answered and checks is answer correct or false.
    /// - Parameters:
    ///   - currentQuestion: Question displayed on the screen.
    ///   - selectedAnswer: Answer selected by user.
    fileprivate func answeredOperations(_ currentQuestion: Question, _ selectedAnswer: String) {
        if let index = currentQuestionsArray.firstIndex(where: { $0.isAnswered == nil}){
            /// Check answer is correct and also set current question as answered.
            currentQuestionsArray[index].isAnswered = true
            if currentQuestion.correctAnswer == selectedAnswer {
                currentQuestionsArray[index].isCorrectAnswered = true
                print("CurrentAnswers: \(currentQuestionsArray)")
            } else {
                currentQuestionsArray[index].isCorrectAnswered = false
                print("CurrentAnswers2: \(currentQuestionsArray)")
            }
            /// Quiz finished. Show results
            /// Added one to index for preventing last question to appear twice.
            if index + 1 == currentQuestionsArray.count {
                openQuizResultVC(currentQuestionsArray: currentQuestionsArray, currentQuiz: currentQuiz)
            }
        }
    }
}


extension QuizViewController : GADBannerViewDelegate {
    
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
}

