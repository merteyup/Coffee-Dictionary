//
//  MasterEducationViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 28.03.2023.
//

import UIKit

class MasterEducationViewController: UIViewController {
    
    
    @IBOutlet var viewContainer: UIView!
    var views : [UIView]!
    
    @IBOutlet weak var segmentedView: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        views = [UIView]()
        views.append(BlogViewController().view)
        views.append(BlogViewController().view)
        


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for v in views {
            viewContainer.addSubview(v)
            viewContainer.bringSubviewToFront(views[0])
        }

    }
    
    
    @IBAction func switchViewController(_ sender: UISegmentedControl) {
        self.viewContainer.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
    

 

}
