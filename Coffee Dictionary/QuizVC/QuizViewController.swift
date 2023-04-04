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
                    let newQuestions = Question.getQuestionFromObject(object: document.data())
                    print("newQuestions: \(newQuestions)")

                }
            }
            DispatchQueue.main.async {
              //  NotificationCenter.default.post(name: Notification.Name("dismissLoadingVC"), object: nil)
              //  self.tableView.reloadData()
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
        
        
        return cell

    }
    
    
    
    
    
}
