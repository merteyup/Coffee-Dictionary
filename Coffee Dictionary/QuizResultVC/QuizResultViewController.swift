//
//  QuizResultViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 8.04.2023.
//

import UIKit

class QuizResultViewController: UIViewController {
    
    // MARK: - Variables
    var currentQuestionsArray = [Question]()

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            cell.updateCell(currentQuestionArray: currentQuestionsArray)
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

extension QuizResultViewController : QuizResultTableViewCell3Delegate {
    
    func dismissPage() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
