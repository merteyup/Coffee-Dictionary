//
//  BlogDetailViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 7.03.2023.
//

import UIKit
import GoogleMobileAds

class BlogDetailViewController: UIViewController, GADBannerViewDelegate {
    
    // MARK: - Variables
    var selectedBlogPost = Blog()
    var bannerView: GADBannerView!

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = Constants.bannerAdTestId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self


    }
    
    // MARK: - Functions
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
        addBannerViewToView(bannerView)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }

}

// MARK: - TableViewExtension
extension BlogDetailViewController : UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogDetailTableViewCellID", for: indexPath) as! BlogDetailTableViewCell
        cell.blogDetailTableViewCellDelegate = self
        let sentence = selectedBlogPost.blogPost
        let lines = sentence.split(whereSeparator: \.isNewline)
        
        cell.lblTitle.text = selectedBlogPost.title
        cell.lblBlogPost.text = selectedBlogPost.blogPost.replacingOccurrences(of: "\\n", with: "\n")

        if let url = URL(string: selectedBlogPost.imageUrl) {
            cell.imgBlogPost.af_setImage(withURL: url, placeholderImage: nil, filter: nil,  imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false, completion: {response in
            })
        }
    
        return cell
        
    }
}

extension BlogDetailViewController : BlogDetailTableViewCellDelegate {
    
    func listenPressed() {
        
    }
    
}
