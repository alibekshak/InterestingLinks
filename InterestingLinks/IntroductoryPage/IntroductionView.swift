//
//  IntroductionView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct IntroductionView: View {
    
    @StateObject var viewModel: IntroductionViewModel
    
    var body: some View {
        ZStack {
            Image("fon")
                .resizable()
                .scaledToFill()
                .clipped()
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Spacer()
                TextIntraductionView()
                
                Button(action: {
                    viewModel.onEvent?(.next)
                }) {
                    Text("Let’s start")
                }
                .buttonStyle(CustomButtonStyle(backgroundColor: .white, textColor: .black))
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    IntroductionView(viewModel: IntroductionViewModel())
}


