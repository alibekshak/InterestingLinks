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
        VStack(alignment: .center) {
            if viewModel.links.isEmpty {
                textForWelcoming
            } else {
                listOfLinks
            }
            buttonAddLink
        }
        .padding(.top)
        .navigationBarItems(trailing: EditButton())
        .onAppear {
            viewModel.loadLinksFromUserDefault()
        }
    }
    
    var textForWelcoming: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Add your first link")
                .font(.system(
                    size: 28,
                    weight: .semibold,
                    design: .serif)
                )
            AnimatedVerticalBars()
        }
        .frame(maxHeight: .infinity)
    }
    
    var listOfLinks: some View {
        List {
            ForEach(viewModel.links) { link in
                ListOfLinksView(links: link)
            }
            .onDelete(perform: viewModel.removeLink)
            .onMove(perform: viewModel.moveLink)
        }
        .listStyle(PlainListStyle())
    }
    
    var buttonAddLink: some View {
        Button(action: {
            viewModel.onEvent?(.openSheet)
        }) {
            Text("Add Link")
        }
        .buttonStyle(CustomButtonStyle(backgroundColor: .black, textColor: .white))
        .padding(.bottom)
        .padding(.horizontal, 16)
    }
}


#Preview {
    AddLinksView(viewModel: InterestingLinksViewModel())
}
