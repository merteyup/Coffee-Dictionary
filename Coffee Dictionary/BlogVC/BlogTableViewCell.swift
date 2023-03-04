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

}
