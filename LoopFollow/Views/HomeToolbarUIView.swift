//
//  ToolbarUIView.swift
//  LoopFollow
//
//  Created by fraz on 10/26/23.
//  Copyright © 2023 Jon Fawcett. All rights reserved.
//

import SwiftUI

struct HomeToolbarUIView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: self.action, label: {
            Text("Add new person")
        })
    }
}

#Preview {
    HomeToolbarUIView(action: {print("Add new person button!")})
}
