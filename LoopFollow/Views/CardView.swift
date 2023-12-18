/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct CardView: View {
    let followCard: UserCard
    let actionSettingsPage: () -> Void
    let actionMainPage: () -> Void

    var body: some View {
        Button(action: self.actionMainPage) {
            VStack(alignment: .leading) {
                HStack() {
                    Circle()
                        .fill(followCard.color)
                        .frame(width: 44, height: 44, alignment: .center)
                        .overlay(Text(followCard.name.prefix(1)))
                    VStack(alignment: .leading) {
                        Text(followCard.name)
                            .font(.headline)
                        Label((followCard.hasAlerts ? "There are alerts": "no alerts"), systemImage: "exclamationmark.triangle")
                            .labelStyle(.titleAndIcon)
                            .font(.caption)
                            .opacity(followCard.hasAlerts ? 1 : 0)
                    }
                    Spacer()
                    Button(action: self.actionSettingsPage, label: {
                        Image(systemName: "gearshape.fill")
                            .padding()
                            .frame(width: 30, height: 30, alignment: .center)
                            .foregroundColor(.gray)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    })
                    .opacity(0.8)
                    Text("\(followCard.bg)")
                        .font(.largeTitle)
                }
            }
            .padding()
//            .foregroundColor(userCard.theme.accentColor)
        }
    }
}

#Preview {
    CardView(followCard: UserCard.sampleData[0], actionSettingsPage: {print("SETTINGS!!")}, actionMainPage: {print("MAIN!!")})
}


