//
//  BlogViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 3.03.2023.
//

import UIKit
import FirebaseFirestore


class BlogViewController: UIViewController {
    
    
    let db = Firestore.firestore()
    var blogsArray = [Blog]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        db.collection("blogs").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    print("BlogPost: \(document.data())")

                    
                    if let blogPost = document.data()["blogPost"] as? String {
                        if let title = document.data()["title"] as? String {
                            if let createdAt = document.data()["createdAt"] as? Timestamp {
                                let date = Date(timeIntervalSince1970: createdAt)


                                let newBlogPost = Blog(title: title, blogPost: blogPost, createdAt: createdAt)
                                self.blogsArray.append(newBlogPost)
                                
                                print("BlogPost: \(self.blogsArray)")
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
}
    
    
    extension BlogViewController : UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return blogsArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCellID", for: indexPath) as! BlogTableViewCell
            
            cell.lblTitle.text = blogsArray[indexPath.row].title
            
            return cell
            
            
        }
        
        
        
        
        
        
    }
