//
//  TextIntraductionView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct TextIntraductionView: View {
    var body: some View {
        Text("Save all interesting links in one app")
            .foregroundColor(.white)
            .font(Font.custom("Helvetica", size: 36)
                .weight(.bold))
            .frame(width: 358, alignment: .leading)
    }
}

#Preview {
    TextIntraductionView()
        .background(Color.black)
}
