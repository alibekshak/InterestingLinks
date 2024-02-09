//
//  AddLinksView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct AddLinksView: View {
    
    @StateObject var viewModel: AddLinksViewModel
    
    @StateObject var writeDownViewModel: WriteDownInfoViewModel
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            List(writeDownViewModel.links) { link in
                ListOfLinksView(links: link)
            }
            .listStyle(PlainListStyle())
            
            Button(action: {
                viewModel.onEvent?(.openSheet)
            }) {
                Text("Add Link")
            }
            .buttonStyle(CustomButtonStyle(backgroundColor: .black, textColor: .white))
            .padding(.bottom)
        }
        
    }
}


#Preview {
    AddLinksView(viewModel: AddLinksViewModel(), writeDownViewModel: WriteDownInfoViewModel())
}
