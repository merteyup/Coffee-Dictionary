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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getQuestions()
        playLottieAnimation()

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
                                        
                    if let quizzes = Question.getQuizzesFromObject(object: document.data()) {
                        print("CountCount3: \(quizzes)")
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
        
        cell.lblQuizTopic.text = currentQuizzes[indexPath.row].quizTopic
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let singleQuiz = currentQuizzes[indexPath.row].singleQuiz {
            openQuizVC(currentQuestionsArray: singleQuiz)
        }
        
        
    }
    
    
    
    
}