//
//  LaunchScreen.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 10.09.2024.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Image(systemName: "link")
                .font(
                    .system(
                        size: 75,
                        weight: .semibold
                    )
                )
            AnimatedVerticalBars()
                .padding(.top, 180)
        }
    }
}

#Preview {
    LaunchScreen()
}
