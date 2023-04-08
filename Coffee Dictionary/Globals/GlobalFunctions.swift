//
//  Globals.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 16.02.2023.
//

import Foundation
import UIKit
import AVFAudio


extension UIView {
    
    func roundedCorners(round: Double) {
        layer.cornerRadius = round
        layer.masksToBounds = true
    }
    
    func addProductBorder(round: Double) {
        clipsToBounds = true
        layer.masksToBounds = false
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = round
    }
    
    func removeProductBorder() {
        layer.borderWidth = 0
        
    }
    
    func addRightRoundCorners(round: Double) {
        clipsToBounds = true
        layer.cornerRadius = round
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
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
    
 
    func addBtnShadow(button: UIButton) {
        button.roundedCorners(round: 10)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: -1.0, height: 4.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.5
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
    }
    
    
 
}

extension UIViewController {
    
    func openLoadingVC() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let vc: LoadingViewController = storyboard.instantiateViewController(withIdentifier: "LoadingViewControllerID") as! LoadingViewController;
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil);
    }
    
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
    
    func openPremiumPage(premiumPageId: Int) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        if premiumPageId == 1 {
            let vc: FirstPremiumViewController = storyboard.instantiateViewController(withIdentifier: "FirstPremiumViewControllerID") as! FirstPremiumViewController;
            vc.modalPresentationCapturesStatusBarAppearance = true
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil);
        } else if premiumPageId == 2 {
            let vc: SecondPremiumViewController = storyboard.instantiateViewController(withIdentifier: "SecondPremiumViewControllerID") as! SecondPremiumViewController;
            vc.modalPresentationCapturesStatusBarAppearance = true
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil);
        }
    }
    
    func openCoffeeDetailVC(viewController: CoffeeListViewController) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let vc: FilterViewController = storyboard.instantiateViewController(withIdentifier: "FilterViewControllerID") as! FilterViewController;
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.filterViewControllerDelegate = viewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil);
    }
    
    func openQuizVC(currentQuestionsArray: [Question]) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let vc: QuizViewController = storyboard.instantiateViewController(withIdentifier: "QuizViewControllerID") as! QuizViewController;
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.currentQuestionsArray = currentQuestionsArray
        self.present(vc, animated: true, completion: nil);
    }
    
    
}




