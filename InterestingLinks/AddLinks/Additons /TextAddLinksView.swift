//
//  TextAddLinksView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct TextAddLinksView: View {
    var body: some View {
        Text("Save your first bookmark")
            .font(Font.custom("Helvetica", size: 36)
                .weight(.semibold))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    TextAddLinksView()
}
