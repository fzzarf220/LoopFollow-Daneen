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

struct HomeSwiftUIViewController: View {
    @State var followCards: [FollowCard]
    @State private var hasAccounts: Bool = true
    @State private var path = NavigationPath()

    var body: some View {
        
        ZStack {
//            storyboardView().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            NavigationStack (path: $path) {
                VStack(alignment:.trailing) {
                    List {
                        ForEach(followCards, id: \.self) {
                            followCard in CardView(followCard: followCard, actionSettingsPage: {
                                print("clicked settings")
                                path.append("Settings")
                            }, actionMainPage: {
                                print("clicked main page")
                                path.append("Main")
                            })
                                .listRowBackground(followCard.theme.mainColor)
                        }
                        .onDelete(perform: {
                            (index) in self.followCards.remove(atOffsets: index)
                        })
                        .onMove(perform: { (fromOffsets, newOffset) in
                            self.followCards.move(fromOffsets: fromOffsets, toOffset: newOffset)
                        })
                    }
                    .navigationBarItems(trailing: EditButton())
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HomeToolbarUIView(action: {print("Create a person!")})
                    }
                }
                .navigationDestination(for: String.self) { view in
                    if view == "Main" {
                        MainUIKitViewController()
                    }
                    if view == "Settings" {
                        SettingsUIKitViewController()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeSwiftUIViewController(followCards: FollowCard.sampleData)
}

struct storyboardView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "Home")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct MainUIKitViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = MainViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}


struct SettingsUIKitViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = SettingsViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
