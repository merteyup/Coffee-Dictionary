//
//  BlogDetailTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 7.03.2023.
//

import UIKit

protocol BlogDetailTableViewCellDelegate : AnyObject {
    
    func listenPressed(cell: BlogDetailTableViewCell)
    
}

class BlogDetailTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    weak var blogDetailTableViewCellDelegate: BlogDetailTableViewCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBlogPost: UIImageView!
    @IBOutlet weak var lblBlogPost: UILabel!
    @IBOutlet weak var btnListenTip: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func updateCell(blogPost: Blog) {
        let sentence = blogPost.blogPost
        let lines = sentence.split(whereSeparator: \.isNewline)
        lblTitle.text = blogPost.title
        lblBlogPost.text = blogPost.blogPost.replacingOccurrences(of: "\\n", with: "\n")
        if let url = URL(string: blogPost.imageUrl) {
            imgBlogPost.af_setImage(withURL: url, placeholderImage: nil, filter: nil,  imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false, completion: {response in
            })
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func listenPressed(_ sender: UIButton) {
        blogDetailTableViewCellDelegate?.listenPressed(cell: self)
        
    }
    

}
