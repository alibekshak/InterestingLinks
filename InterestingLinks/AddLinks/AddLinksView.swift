//
//  AddLinksView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct AddLinksView: View {
    
    @StateObject var viewModel: InterestingLinksViewModel
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            List(viewModel.links) { link in
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
    AddLinksView(viewModel: InterestingLinksViewModel())
}
