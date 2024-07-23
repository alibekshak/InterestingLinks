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
            
            VStack(alignment: .center, spacing: 24) {
                Spacer()
                textInfo
                buttonStart
            }
            .padding(.bottom)
        }
    }
    
    var buttonStart: some View {
        Button(action: {
            viewModel.loadLinksFromUserDefault()
            viewModel.onEvent?(.next)
        }) {
            Text("Let’s start")
        }
        .buttonStyle(CustomButtonStyle(backgroundColor: .white, textColor: .black))
    }
    
    var textInfo: some View {
        Text("Save all interesting links in one app")
            .foregroundColor(.white)
            .font(.system(
                size: 36,
                weight: .bold,
                design: .rounded)
            )
            .multilineTextAlignment(.center)
        
    }
}

#Preview {
    IntroductionView(viewModel: InterestingLinksViewModel())
}


