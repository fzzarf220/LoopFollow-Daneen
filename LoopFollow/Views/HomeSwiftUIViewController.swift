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
    @Binding var userProfiles: UserProfilesStruct
    @State private var path = NavigationPath()

    var body: some View {
        ZStack {
            NavigationStack (path: $path) {
                VStack(alignment:.trailing) {
                    List {
                        ForEach(userProfiles.profiles) {
                            userProfile in CardView(followCard: UserCard(id: userProfile.id, name: userProfile.name, bg: 120, color: Color.red), actionSettingsPage: {
                                print("clicked settings")
                                print("lets check id \(userProfile.id)")

                                if let _ = self.userProfiles.select(id: userProfile.id) {
                                    path.append("Settings")
                                }
                            }, actionMainPage: {
                                print("clicked main page")
                                
                                if let _ = self.userProfiles.select(id: userProfile.id) {
                                    path.append("Main")
                                }
                            })
//                            .listRowBackground(Color.black)
                        }
                        .onDelete(perform: {
                            (index) in self.userProfiles.remove(atOffsets: index)
                        })
                        .onMove(perform: { (fromOffsets, newOffset) in
                            self.userProfiles.move(fromOffsets: fromOffsets, toOffset: newOffset)
                        })
                    }
                    .navigationBarItems(trailing: EditButton())
                    .foregroundColor(.primary)
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HomeToolbarUIView(action: {
                            print("Create a person!")
                            let profile = UserProfile(name: "Saffan", iconUrl: "", color: "red")
                            self.userProfiles.add(profile: profile)
                        })
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

struct HomeSwiftUIViewControllerOld: View {
    @State var userCards: [UserCard]
    @State private var hasAccounts: Bool = true
    @State private var path = NavigationPath()

    var body: some View {
        
        ZStack {
            NavigationStack (path: $path) {
                VStack(alignment:.trailing) {
                    List {
                        ForEach(userCards, id: \.self) {
                            userCard in CardView(followCard: userCard, actionSettingsPage: {
                                print("clicked settings")
                                print("lets check id \(userCard.id)")

                                if let _ = UserProfiles.select(id: userCard.id) {
                                    path.append("Settings")
                                }
                            }, actionMainPage: {
                                print("clicked main page")
                                
                                if let _ = UserProfiles.select(id: userCard.id) {
                                    path.append("Main")
                                }
                            })
//                            .listRowBackground(Color.black)
                        }
                        .onDelete(perform: {
                            (index) in self.userCards.remove(atOffsets: index)
                        })
                        .onMove(perform: { (fromOffsets, newOffset) in
                            self.userCards.move(fromOffsets: fromOffsets, toOffset: newOffset)
                        })
                    }
                    .navigationBarItems(trailing: EditButton())
                    .foregroundColor(.primary)
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HomeToolbarUIView(action: {
                            print("Create a person!")
                            let profile = UserProfile(name: "Saffan", iconUrl: "", color: "red")
                            UserProfiles.add(profile: profile)
                        })
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
    let profile: UserProfilesStruct = UserProfilesStruct
    
    HomeSwiftUIViewController(userProfiles: .constant(profile))
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
