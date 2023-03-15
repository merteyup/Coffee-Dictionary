//
//  MoreTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 22.02.2023.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblMore: UILabel!
    @IBOutlet weak var imgMore: UIImageView!
    
    // MARK: - Statements
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
