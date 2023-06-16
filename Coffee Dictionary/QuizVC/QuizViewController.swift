//
//  QuizViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 4.04.2023.
//

import UIKit


class QuizViewController: UIViewController {
    
    // MARK: - Variables
    var currentQuestionsArray = [Question]()
    var currentQuiz = Quiz(singleQuiz: nil, id: nil, isSolved: nil, quizTopic: nil, badge: nil)
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
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


