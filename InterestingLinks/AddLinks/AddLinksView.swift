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
            List {
                ForEach(viewModel.links) { link in
                    ListOfLinksView(links: link)
                }
                .onDelete(perform: viewModel.removeLink)
                .onMove(perform: viewModel.moveLink)
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
        .navigationBarItems(trailing: EditButton())
    }
}


#Preview {
    AddLinksView(viewModel: InterestingLinksViewModel())
}
