import Foundation
import SwiftUI

struct FollowCard: Hashable, Identifiable {
    let id: UUID
    var name: String
    var bg: Int
    var theme: Theme
    var color: Color
    var hasAlerts: Bool

    init(id: UUID = UUID(), name: String, bg: Int, theme: Theme, color: Color, hasAlerts: Bool = false) {
        self.id = id
        self.name = name
        self.bg = bg
        self.theme = theme
        self.hasAlerts = hasAlerts
        self.color = color
    }
}

extension FollowCard {
  static var sampleData: [FollowCard] {
    [
        FollowCard(name: "Daneen", bg: 180, theme: .yellow, color: Color.pink),
        FollowCard(name: "Saffan", bg: 320, theme: .sky, color: Color.blue, hasAlerts: true),
    ]
  }
}

