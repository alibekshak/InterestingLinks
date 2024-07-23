//
//  WriteDownInfoView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 09.02.2024.
//

import SwiftUI

struct WriteDownInfoView: View {
    
    @StateObject var viewModel: InterestingLinksViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Save your links")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 38)
            CustomTextField(title: "Link Title name", text: $viewModel.titleLink)
            CustomTextField(title: "Link", text: $viewModel.link)
            Spacer()
            buttonSave
        }
        .padding()
    }
    
    var buttonSave: some View {
        Button(action: {
            viewModel.save()
        }) {
            Text("Save")
        }
        .buttonStyle(CustomButtonStyle(backgroundColor: .black, textColor: .white))
    }
}

#Preview {
    WriteDownInfoView(viewModel: InterestingLinksViewModel())
        .presentationDetents([.height(327), .medium, .large])
        .transition(.opacity)
}
