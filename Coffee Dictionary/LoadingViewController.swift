//
//  LoadingViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 18.03.2023.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {

    
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playAnimation()

        NotificationCenter.default.addObserver(self, selector: #selector(dismissLoading), name: Notification.Name("dismissLoadingVC"), object: nil)

    }

    
    @objc func dismissLoading() {
        dismiss(animated: true)
    }

    
   fileprivate func playAnimation() {
        
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
