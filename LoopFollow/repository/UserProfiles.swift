//
//  Profiles.swift
//  LoopFollow
//
//  Created by fraz on 10/30/23.
//  Copyright © 2023 Jon Fawcett. All rights reserved.
//

import Foundation
import SwiftUI

// Model
struct UserProfileOld: Identifiable, Codable {
    var id = UUID()
    let name: String
    let iconUrl: String?
    let color: String?
}

class UserProfiles {
    private static var profiles: [UserProfile] = [UserProfile]() {
        didSet {
            print("data changed!")
            print(profiles)
            
            if let encoded = try? JSONEncoder().encode(profiles) {
                UserProfiles.listener?(UserProfiles.profiles)
                UserDefaults.standard.set(encoded, forKey: "Profiles")
            } else {
                print("Error while trying to encode data")
            }
        }
    }
    
    private static var selected: Int = 0
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "Profiles") {
            if let decoded = try? JSONDecoder().decode([UserProfile].self, from: saved) {
                UserProfiles.profiles = decoded
                return
            }
        }
        
        UserProfiles.profiles = []
    }
    
    private static var listener: (([UserProfile]?) -> Void)?
    
    // inspiration form url: https://www.youtube.com/watch?v=iI0LabCYZJo&ab_channel=iOSAcademy
    static func bind(_ listener: @escaping ([UserProfile]?) -> Void) {
        listener(UserProfiles.profiles)
        UserProfiles.listener = listener
    }
    
    static func add (profile: UserProfile) {
        UserProfiles.profiles.append(profile)
    }
    
    static func remove (index: Int) {
        UserProfiles.profiles.remove(at: index)
    }
    
    static func get() -> UserProfile? {
        let index: Int = UserProfiles.selected
                
        if UserProfiles.profiles.isEmpty {
            return nil
        }
        
        return UserProfiles.profiles[index]
    }
    
    static func getAll() -> [UserProfile] {
        return UserProfiles.profiles
    }
    
    static func select(id: UUID) -> Int? {
        if let index = UserProfiles.profiles.firstIndex(where: {$0.id == id}) {
            UserProfiles.selected = index
            return index
        }

        return nil
    }
    
    static func selectAndGet(index: Int) -> UserProfile? {
        UserProfiles.selected = index
        return UserProfiles.get()
        
    }
}



// Model
struct UserProfile: Identifiable, Codable {
    var id = UUID()
    let name: String
    let iconUrl: String?
    let color: String?
}

struct UserProfilesStruct {
    var profiles: [UserProfile]
    private var selected: Int = 0

    mutating
    func add(profile: UserProfile) {
        self.profiles.append(profile)
    }

    mutating
    func remove(atOffsets: IndexSet) {
        self.profiles.remove(atOffsets: atOffsets)
    }

    mutating
    func select (id: UUID) -> Int? {
        if let index = self.profiles.firstIndex(where: {$0.id == id}) {
            self.selected = index
            return index
        }

        return nil
    }

    mutating
    func move(fromOffsets: IndexSet, toOffset: Int) {
        profiles.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
}
