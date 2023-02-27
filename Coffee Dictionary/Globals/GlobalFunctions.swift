//
//  Globals.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 16.02.2023.
//

import Foundation
import UIKit


extension UIView {
    //If you want only round corners
    func roundedCorners() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
 
}

extension UIViewController {
    func openCoffeeDetailVC(coffee: Coffee) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let vc: CoffeeDetailViewController = storyboard.instantiateViewController(withIdentifier: "CoffeeDetailViewControllerID") as! CoffeeDetailViewController;
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.selectedCoffee = coffee
        self.present(vc, animated: true, completion: nil);
    }
    
    
    func openCoffeeDetailVC(viewController: CoffeeListViewController) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let vc: FilterViewController = storyboard.instantiateViewController(withIdentifier: "FilterViewControllerID") as! FilterViewController;
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.filterViewControllerDelegate = viewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil);
    }
    
}

