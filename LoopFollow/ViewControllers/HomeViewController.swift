//
//  HomeViewController.swift
//  LoopFollow
//
//  Created by fraz on 10/26/23.
//  Copyright © 2023 Jon Fawcett. All rights reserved.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    @IBOutlet weak var theContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let childView = UIHostingController(rootView: HomeSwiftUIViewController(followCards: FollowCard.sampleData))
        
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
