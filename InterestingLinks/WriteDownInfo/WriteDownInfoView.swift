//
//  WriteDownInfoView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 09.02.2024.
//

import SwiftUI

struct WriteDownInfoView: View {
    
    @StateObject var viewModel: WriteDownInfoViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            
            linkTitle
            
            webLink
            
            Button(action: {
                viewModel.onEvent?(.save)
            }) {
                Text("Save")
            }
            .buttonStyle(CustomButtonStyle(backgroundColor: .black, textColor: .white))
        }
        .padding()
        
    }
    
    var linkTitle: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 58)
                .foregroundColor(.gray.opacity(0.2))
            
            TextField("Link Title name", text: $viewModel.titleLink)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
        }
    }
    
    var webLink: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 58)
                .foregroundColor(.gray.opacity(0.2))
            
            TextField("Link", text: $viewModel.link)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    WriteDownInfoView(viewModel: WriteDownInfoViewModel())
        .presentationDetents([.height(327), .medium, .large])
        .transition(.opacity)
}
