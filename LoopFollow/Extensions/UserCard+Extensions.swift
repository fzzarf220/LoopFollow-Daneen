import Foundation
import SwiftUI

struct UserCard: Hashable, Identifiable {
    let id: UUID
    var name: String
    var bg: Int
    var color: Color
    var hasAlerts: Bool

    init(id: UUID = UUID(), name: String, bg: Int, color: Color, hasAlerts: Bool = false) {
        self.id = id
        self.name = name
        self.bg = bg
        self.hasAlerts = hasAlerts
        self.color = color
    }
}

extension UserCard {
  static var sampleData: [UserCard] {
    [
        UserCard(name: "Daneen", bg: 180, color: Color.pink),
        UserCard(name: "Saffan", bg: 320, color: Color.blue, hasAlerts: true),
    ]
  }
}

