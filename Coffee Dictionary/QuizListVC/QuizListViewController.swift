//
//  QuizListViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 6.04.2023.
//

import UIKit
import FirebaseFirestore
import Lottie


class QuizListViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    let db = Firestore.firestore()
    
    var currentQuizzes = [Quiz]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let earnedBadgesArray = Constants.saveLoad.object(forKey: "earnedBadgesArray") {
            print("EarnedBadgesArray: \(earnedBadgesArray)")
        } else {
#warning("Update this part dynamically")
        openBadgeVC(badgeTitle: "Solve your first quiz, earn beginner badge.",
                    badgeName: "badge1")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        getQuestions()
        playLottieAnimation()
        // Observe in app purchases.
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: Notification.Name("purchaseCompleted"), object: nil)
        
    }
    
    @objc func reloadCollectionView () {
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
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
            }
        }
    }
    
    
    
}


extension QuizListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentQuizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizListCollectionViewCellID", for: indexPath) as! QuizListCollectionViewCell
        cell.lblQuizIndex.text = "Quiz: \(indexPath.row + 1)"
        
        if !isVipMember {
            if indexPath.row >= 3 {
                cell.imgLock.alpha = 0.8
            } else {
                cell.imgLock.alpha = 0
            }
        }
        
        if let quizTopic = currentQuizzes[indexPath.row].quizTopic {
            cell.updateCell(quizTopic: quizTopic)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !isVipMember {
            if indexPath.row >= 3 {
                openPremiumPage(premiumPageId: 1)
            } else {
                if let singleQuiz = currentQuizzes[indexPath.row].singleQuiz {
                    openQuizVC(currentQuestionsArray: singleQuiz, quizId: currentQuizzes[indexPath.row].id ?? "defaultQuizId")
                }
            }
        } else {
            if let singleQuiz = currentQuizzes[indexPath.row].singleQuiz {
                print("SelectedQuiz: \(currentQuizzes[indexPath.row].id)")
                openQuizVC(currentQuestionsArray: singleQuiz, quizId: currentQuizzes[indexPath.row].id ?? "defaultQuizId")
            }
        }
    }
    
    
    
    
}
