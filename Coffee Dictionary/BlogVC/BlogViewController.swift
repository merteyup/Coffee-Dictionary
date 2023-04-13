//
//  BlogViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 3.03.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage



class BlogViewController: UIViewController {
    
    // MARK: - Variables
    let db = Firestore.firestore()
    var blogsArray = [Blog]()
    let storage = Storage.storage()
    var imagesArray = [UIImage]()
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Statements
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkInternetConnection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Functions
    fileprivate func checkInternetConnection() {
        #warning("This part could be tested in real device.")
        if NetworkMonitor.shared.isConnected {
            getBlogPosts()
        } else {
            let alertbox = UIAlertController(title: "You're Offline", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Go to settings", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
            let closeAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {_ in 
                alertbox.dismiss(animated: true)
            }
            alertbox.addAction(okAction)
            alertbox.addAction(closeAction)
            DispatchQueue.main.async {
                self.present(alertbox, animated: true, completion: nil)
            }
        }
    }
    fileprivate func getBlogPosts() {
        if blogsArray.count == 0 {
            openLoadingVC()
            db.collection("blogs").order(by: "createdAt", descending: true).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("BlogPost: \(document.data())")
                        let newBlogPost = Blog.parseBlogPost(document)
                        self.blogsArray.append(newBlogPost)
                    }
                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("dismissLoadingVC"), object: nil)
                    self.tableView.reloadData()
                }
            }
        }
    }
}




    // MARK: - TableViewExtension
extension BlogViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCellID", for: indexPath) as! BlogTableViewCell
        
        
        if !isVipMember {
            if indexPath.row >= 3 {
                cell.imgLock.alpha = 0.8
            } else {
                cell.imgLock.alpha = 0
            }
        }
        
        cell.updateCell(blogPost: blogsArray[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if !isVipMember {
            if indexPath.row >= 3 {
                openPremiumPage(premiumPageId: 1)
            } else {
                openBlogDetailVC(selectedBlogPost: blogsArray[indexPath.row])
            }
        } else {
            openBlogDetailVC(selectedBlogPost: blogsArray[indexPath.row])
        }
        
    }
    
    
}

