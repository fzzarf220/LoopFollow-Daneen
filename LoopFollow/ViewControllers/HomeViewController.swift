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
        self.initView(uiView: theContainer)
        
//        UserProfiles.bind { [weak self] _ in
//            DispatchQueue.main.async {
//                // refresh view on data
//                print("\nHomeViewController: refresh view on data change <-------------------------------")
//                self?.theContainer.layoutIfNeeded()
//            }
//        }
    }
    
    private func initView(uiView: UIView) {
//        let userCards: Array<UserCard> = UserProfiles.getAll()
//            .map {
//
//                return UserCard(id: $0.id, name: $0.name, bg: 120, color: Color.red)
//            }
        
        print("Displaying the view")

//        let childView = UIHostingController(rootView: HomeSwiftUIViewController(userCards: userCards))
        let childView = UIHostingController(rootView: HomeSwiftUIViewController(userProfiles: .constant(UserProfilesStruct())))
        
        addChild(childView)
        childView.view.frame = uiView.bounds
        uiView.addSubview(childView.view)
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
