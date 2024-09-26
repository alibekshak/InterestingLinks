//
//  IntroductionView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct IntroductionView: View {
    
    @StateObject var viewModel: InterestingLinksViewModel
    
    var body: some View {
        ZStack {
            Image("fon")
                .resizable()
                .ignoresSafeArea()
            
            AnimatedVerticalBars(introPage: true)
            
            VStack(alignment: .center, spacing: 54) {
                Spacer()
                textInfo
                buttonStart
            }
            .padding(.bottom, 34)
        }
    }
    
    var buttonStart: some View {
        Button(action: {
            viewModel.onEvent?(.next)
        }) {
            Text("Let’s start")
        }
        .buttonStyle(CustomButtonStyle(backgroundColor: .white, textColor: .black))
        .padding(.horizontal, 16)
    }
    
    var textInfo: some View {
        Text("Save all interesting links in one app")
            .foregroundColor(.white)
            .font(.system(
                size: 36,
                weight: .bold,
                design: .serif)
            )
            .multilineTextAlignment(.center)
        
    }
}

#Preview {
    IntroductionView(viewModel: InterestingLinksViewModel())
}


