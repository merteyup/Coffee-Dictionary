//
//  QuizListViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 6.04.2023.
//

import UIKit
import FirebaseFirestore
import Lottie
import CoreData


class QuizListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    // MARK: - Variables
    let db = Firestore.firestore()
    var currentQuizzes = [Quiz]()
    var availableBadges = [Badge]()
    
    
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getQuestions()
        playLottieAnimation()
        // Observe in app purchases.
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: Notification.Name("purchaseCompleted"), object: nil)
        
    }
    
   // MARK: - Functions
    
    fileprivate func playLottieAnimation() {
        // 1. Set animation content mode
        animationView.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        animationView.loopMode = .loop
        // 3. Adjust animation speed
        animationView.animationSpeed = 0.85
        // 4. Play animation
        animationView.play()
    }
    
    
    fileprivate func getQuestions() {
        //  openLoadingVC()
        // Add every document to array.
        // Save this array to user defaults.
        // Ask different document from database.
        db.collection("quiz").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    if let quizzes = Question.getQuizzesFromObject(object: document.data(), documentId: document.documentID) {
                        self.currentQuizzes.append(quizzes)
                    }
                }
            }
            
            DispatchQueue.main.async {
                //  NotificationCenter.default.post(name: Notification.Name("dismissLoadingVC"), object: nil)
                self.collectionView.reloadData()
                if let badgesToShow = Badge.fetchCurrentBadges(currentQuizzes: self.currentQuizzes,
                                                               isForSingleBadge: true) {
                    guard let singleBadge = badgesToShow.last else {return}
                    self.openBadgeVC(badge: singleBadge)
                }
            }
        }
    }
    
    

    
    @objc func reloadCollectionView () {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    /*
     if let earnedBadgesArray = Constants.saveLoad.object(forKey: "earnedBadgesArray") {
     guard let badge = self.currentQuizzes[0].badge else {return}
     self.openBadgeVC(badge: badge)
     
     } else {
     #warning("Update this part dynamically")
     guard let badge = self.currentQuizzes[0].badge else {return}
     self.openBadgeVC(badge: badge)
     } */
    
}






extension QuizListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentQuizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizListCollectionViewCellID", for: indexPath) as! QuizListCollectionViewCell
       
        if !isVipMember {
            if indexPath.row >= 3 {
                cell.imgLock.alpha = 0.8
            } else {
                cell.imgLock.alpha = 0
            }
        }
        
        
        cell.updateCell(currentQuiz: currentQuizzes[indexPath.row], indexPath: indexPath.row)

        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !isVipMember {
            if indexPath.row >= 3 {
                openPremiumPage(premiumPageId: 1)
            } else {
                if let singleQuiz = currentQuizzes[indexPath.row].singleQuiz {
                    openQuizVC(currentQuestionsArray: singleQuiz,
                               currentQuiz: currentQuizzes[indexPath.row])
                }
            }
        } else {
            if let singleQuiz = currentQuizzes[indexPath.row].singleQuiz {
                print("SelectedQuiz: \(currentQuizzes[indexPath.row].id)")
                openQuizVC(currentQuestionsArray: singleQuiz,
                           currentQuiz: currentQuizzes[indexPath.row])
            }
        }
    }
    
    
    
    
}
