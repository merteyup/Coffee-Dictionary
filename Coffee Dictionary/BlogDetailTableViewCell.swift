//
//  BlogDetailTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 7.03.2023.
//

import UIKit

class BlogDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBlogPost: UIImageView!
    @IBOutlet weak var lblBlogPost: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
