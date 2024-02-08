//
//  TitleView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct TitleView: View {
    
    let width: CGFloat
    let height: CGFloat
    let title: String
    
    var body: some View {
        Text(title)
            .font(Font.custom("Helvetica", size: 22)
                .weight(.bold))
            .foregroundColor(.primary)
            .position(x: width / 2, y: height / 12)

    }
}

#Preview {
    TitleView(width:  400, height: 100, title: "Links App")
}
