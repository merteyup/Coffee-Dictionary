//
//  CoffeeDetailCell.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 15.02.2023.
//

import UIKit
import Lottie

class CoffeeDetailCell: UITableViewCell {
    
// MARK: - Outlets
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRoaster: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var backgroundInfo: UIView!
    
    @IBOutlet weak var lblDesc1: UILabel!
    @IBOutlet weak var lblDesc1Header: UILabel!
    @IBOutlet weak var lblDesc2: UILabel!
    @IBOutlet weak var lblDesc2Header: UILabel!
    @IBOutlet weak var lblDesc3Header: UILabel!
    @IBOutlet weak var lblDesc3: UILabel!
    
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    var starArray = [UIImageView]()
    
    // MARK: - Statements
     override func awakeFromNib() {
        super.awakeFromNib()
         starArray.append(imgStar1)
         starArray.append(imgStar2)
         starArray.append(imgStar3)
         starArray.append(imgStar4)
         starArray.append(imgStar5)

         
         
        playLottieAnimation()
        backgroundInfo.roundedCorners()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func updateCell(selectedCoffee: Coffee) {
        lblName.text = selectedCoffee.name
       // lblRoaster.text = selectedCoffee.roaster
       // lblRoast.text = selectedCoffee.roast
        updateRateImage(rate: selectedCoffee.rating)
        lblRate.text = String("Rate: \(selectedCoffee.rating)")
        lblOrigin.text = String("Origin: \(selectedCoffee.origin_1)")
        lblRoaster.text = selectedCoffee.roaster
        lblDesc1.text = selectedCoffee.desc_1
        lblDesc1Header.text = "Review 1"
        lblDesc2.text = selectedCoffee.desc_2
        lblDesc2Header.text = "Review 2"
        lblDesc3.text = selectedCoffee.desc_3
        lblDesc3Header.text = "Review 3"
    }
    
    func updateRateImage(rate: Int) {
         if rate >= 95 {
            starArray.last?.image = UIImage(systemName: "star.fill")
        } else if rate >= 90 {
            starArray.last?.image = UIImage(systemName: "star.leadinghalf.filled")
        } else if rate >= 85 {
            starArray.last?.image = UIImage(systemName: "star")
        } else if rate >= 80 {
            starArray.last?.image = UIImage(systemName: "star")
            starArray[3].image = UIImage(systemName: "star.leadinghalf.filled")
        }        
    }
    
// MARK: - Functions
    fileprivate func playLottieAnimation() {
        // 1. Set animation content mode
        animationView.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        animationView.loopMode = .loop
        // 3. Adjust animation speed
        animationView.animationSpeed = 0.7
        // 4. Play animation
        animationView.play()
    }
}
