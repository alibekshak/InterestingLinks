//
//  WriteDownInfoView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 09.02.2024.
//

import SwiftUI

struct WriteDownInfoView: View {
    
    @StateObject var viewModel: AddLinksViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Save your links")
                .font(.system(
                    size: 32,
                    weight: .semibold,
                    design: .serif)
                )
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
        .disabled(viewModel.titleLink.isEmpty || viewModel.link.isEmpty)
    }
}

#Preview {
    WriteDownInfoView(viewModel: AddLinksViewModel())
        .presentationDetents([.height(327), .medium, .large])
        .transition(.opacity)
}
