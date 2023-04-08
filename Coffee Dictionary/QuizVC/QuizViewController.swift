//
//  QuizViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 4.04.2023.
//

import UIKit

class QuizViewController: UIViewController {
    
    var currentQuestionsArray = [Question]()


    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SelectedQuiz:1 \(currentQuestionsArray)")

        
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
        

        if let index = currentQuestionsArray.firstIndex(where: { $0.isAnswered == nil}){
            currentQuestionsArray[index].isAnswered = true
            if currentQuestion.correctAnswer == selectedAnswer {
                currentQuestionsArray[index].isCorrectAnswered = true
            } else {
                currentQuestionsArray[index].isCorrectAnswered = false
            }
        } else {
            
            // Show result screen

        }
        
        for answer in currentQuestionsArray {
            print(answer.isCorrectAnswered)
        }
       
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func dismissPage() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
 
    

    
}
