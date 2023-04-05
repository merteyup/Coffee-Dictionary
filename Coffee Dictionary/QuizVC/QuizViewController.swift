//
//  QuizViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 4.04.2023.
//

import UIKit
import FirebaseFirestore

class QuizViewController: UIViewController {
    
    let db = Firestore.firestore()
    var currentQuestionsArray = [Question]()


    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getQuestions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                    if let incomingQuestions = Question.getQuestionFromObject(object: document.data()) {
                        self.currentQuestionsArray = incomingQuestions
                    }
                }
            }
            DispatchQueue.main.async {
              //  NotificationCenter.default.post(name: Notification.Name("dismissLoadingVC"), object: nil)
                self.tableView.reloadData()
            }
        }
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
            cell.updateCell(currentQuestion: currentQuestionsArray[index])
        }
        
        
        return cell

    }
    
    
    
    
    
}

extension QuizViewController : QuizTableViewCellDelegate {
    func answerPressed(currentQuestion: Question, selectedAnswer: String) {

        if let index = currentQuestionsArray.firstIndex(where: { $0.isAnswered == nil}){
            currentQuestionsArray[index].isAnswered = true
        }
        
        if currentQuestion.correctAnswer == selectedAnswer {
            print("Correct Answer Selected")
        } else {
            print("False Answer Selected")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
 
    

    
}
