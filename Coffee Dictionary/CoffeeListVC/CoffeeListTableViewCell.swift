//
//  CoffeeListTableViewCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 14.02.2023.
//

import UIKit

protocol CoffeeListTableViewCellDelegate: AnyObject {
    func cell(_ cell: CoffeeListTableViewCell, didTap button: UIButton)
}

class CoffeeListTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    weak var coffeeListTableViewCellDelegate: CoffeeListTableViewCellDelegate?

    // MARK: - Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRoaster: UILabel!
    @IBOutlet weak var lblRoast: UILabel!
    @IBOutlet weak var imgRoast: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    
    // MARK: - Statements
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
 
    // MARK: - Actions
    @IBAction func favoritePressed(_ sender: UIButton) {
        coffeeListTableViewCellDelegate?.cell(self, didTap: sender)
    }
    
    // MARK: - Functions
    
    func updateCell(coffee: Coffee) {
        
        lblName.text = coffee.name
        lblRoaster.text = coffee.roaster
        lblRoast.text = coffee.roast
        imgRoast.image = UIImage(named: coffee.roast)
        if coffee.isFavorite == 0 {
            btnFavorite.setImage(UIImage(systemName: "star.circle"), for: .normal)
            btnFavorite.tintColor = UIColor(named: "appMainColor")
        } else {
            btnFavorite.setImage(UIImage(systemName: "star.circle.fill"), for: .normal)
            btnFavorite.tintColor = .systemYellow
        }
        
    }

}
