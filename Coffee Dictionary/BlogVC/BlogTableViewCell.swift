//
//  BlogTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 3.03.2023.
//

import UIKit

class BlogTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblReadingDuration: UILabel!
    @IBOutlet weak var imgBlogPost: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(blogPost: Blog) {
        lblTitle.text = blogPost.title
        lblDate.text = blogPost.createdAt
        lblReadingDuration.text = "\(countWords(blogPost: blogPost.blogPost)) min read"
    }
    
    func countWords(blogPost: String) -> String {
        
        let components = blogPost.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        var minutes = String()
        if words.count <= 100 {
            minutes = "1"
        } else if words.count > 100 && words.count <= 200 {
            minutes = "2"
        } else if words.count > 200 && words.count <= 300 {
            minutes = "3"
        } else if words.count > 300 && words.count <= 400 {
            minutes = "4"
        } else if words.count > 400 && words.count <= 500 {
            minutes = "5"
        } else if words.count > 500 {
            
            minutes = "6"
        }
        
        print("MinuteCalc: \(words.count)")
        
        return minutes
    }

}
