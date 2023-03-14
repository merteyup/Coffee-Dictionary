//
//  Globals.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 16.02.2023.
//

import Foundation
import UIKit


extension UIView {
    
    func roundedCorners(round: Double) {
        layer.cornerRadius = round
        layer.masksToBounds = true
    }
    
    func addProductBorder() {
        clipsToBounds = true
        layer.masksToBounds = false
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 10
    }
    
    func removeProductBorder() {
        layer.borderWidth = 0
        
    }
    
    func addBottomRoundedEdge(desiredCurve: CGFloat?, view: UIView) {
            let offset: CGFloat = self.frame.width / desiredCurve!
            let bounds: CGRect = self.bounds
            
            let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
            let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
            let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
            let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
            rectPath.append(ovalPath)
            
            // Create the shape layer and set its path
            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = rectPath.cgPath
        
       
            
            // Set the newly created shape layer as the mask for the view's layer
            self.layer.mask = maskLayer
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
    
    func openBlogDetailVC(selectedBlogPost: Blog) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let vc: BlogDetailViewController = storyboard.instantiateViewController(withIdentifier: "BlogDetailViewControllerID") as! BlogDetailViewController;
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.selectedBlogPost = selectedBlogPost
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

