//
//  BlogViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 3.03.2023.
//

import UIKit
import FirebaseFirestore


class BlogViewController: UIViewController {
    
    // MARK: - Variables
    let db = Firestore.firestore()
    
    var blogsArray = [Blog]()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Statements
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBlogPosts()
    }
    
    
    // MARK: - Functions
        
    fileprivate func getBlogPosts() {
        db.collection("blogs").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("BlogPost: \(document.data())")
                    let newBlogPost = Blog.parseBlogPost(document)
                    self.blogsArray.append(newBlogPost)
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
            
            cell.updateCell(blogPost: blogsArray[indexPath.row])
            
            return cell
        }
        
        
    }

