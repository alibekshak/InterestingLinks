//
//  IntroductionButtonView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct IntroductionButtonView: View {
    
    @StateObject var viewModel: IntroductionViewModel
    
    var body: some View {
        Button(action: {
            viewModel.onEvent?(.next)
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 360, height: 56)
                    .foregroundColor(.white)
                    
                Text("Let’s start")
                    .font(Font.custom("Helvetica", size: 16)
                        .weight(.semibold))
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    IntroductionButtonView(viewModel: IntroductionViewModel())
        .padding()
        .background(Color.black)
}
