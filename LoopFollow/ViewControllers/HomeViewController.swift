//
//  HomeViewController.swift
//  LoopFollow
//
//  Created by fraz on 10/26/23.
//  Copyright © 2023 Jon Fawcett. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct HomeViewController: View {
    let followCards: [FollowCard]

    var body: some View {
        NavigationStack {
            VStack(alignment:.trailing) {
                List(followCards) {
                    followCard in CardView(followCard: followCard)
                        .listRowBackground(followCard.theme.mainColor)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {}, label: {
                        Text("Add new person")
                    })
                }
            }
        }
    }
}

#Preview {
    HomeViewController(followCards: FollowCard.sampleData)
}


//
//class debugViewController: UIViewController {
//  
//    
//    var appStateController: AppStateController?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//    
//    
//    
//    
//}
