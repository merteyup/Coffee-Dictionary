//
//  BlogDetailTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 7.03.2023.
//

import UIKit

protocol BlogDetailTableViewCellDelegate : AnyObject {
    
    func listenPressed()
    
}

class BlogDetailTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    weak var blogDetailTableViewCellDelegate: BlogDetailTableViewCellDelegate?
    
    // MARK: - Outlets
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
    
    
    @IBAction func listenPressed(_ sender: UIButton) {
        blogDetailTableViewCellDelegate?.listenPressed()
    }
    

}
