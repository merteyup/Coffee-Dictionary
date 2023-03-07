//
//  BlogDetailViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 7.03.2023.
//

import UIKit

class BlogDetailViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var selectedBlogPost = Blog()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension BlogDetailViewController : UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogDetailTableViewCellID", for: indexPath) as! BlogDetailTableViewCell
        
        cell.lblTitle.text = selectedBlogPost.title
        cell.lblBlogPost.text = selectedBlogPost.blogPost
        
        if let url = URL(string: selectedBlogPost.imageUrl) {
            cell.imgBlogPost.af_setImage(withURL: url, placeholderImage: nil, filter: nil,  imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false, completion: {response in
            })
        }
        
        
        
     //   cell.imgBlogPost.image = selectedBlogPost.image
        
        
        return cell
        
        
    }
    
    
    
    
    
}
