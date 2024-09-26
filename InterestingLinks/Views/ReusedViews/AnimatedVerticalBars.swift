//
//  AnimatedVerticalBars.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 17.07.2024.
//

import SwiftUI

struct AnimatedVerticalBars: View {
    
    var introPage: Bool?
    
    @State private var shouldAnimate = false
    
    private let heights: [CGFloat] = [50, 30, 50, 30, 50]
    
    var body: some View {
        HStack(alignment: .center, spacing: shouldAnimate ? 15 : 5) {
            ForEach(Array(heights.enumerated()), id: \.offset) { index, height in
                CapsuleView(height: height, introPage: introPage)
            }
        }
        .frame(width: shouldAnimate ? 150 : 100)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                self.shouldAnimate = true
            }
        }
    }
}

struct CapsuleView: View {
    var height: CGFloat
    var introPage: Bool?
    
    var body: some View {
        Capsule(style: .continuous)
            .fill(
                introPage ?? false  ?
                Color(.white)
                :
                Color.black
            )
            .frame(width: 10, height: height)
    }
}

#Preview {
    AnimatedVerticalBars()
}
