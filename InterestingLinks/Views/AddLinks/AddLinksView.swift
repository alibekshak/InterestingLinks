//
//  AddLinksView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct AddLinksView: View {
    
    @StateObject var viewModel: AddLinksViewModel
    
    @State var deleteLink: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            if viewModel.links.isEmpty {
                textForWelcoming
            } else {
                navigationBar
                listOfLinks
            }
            buttonAddLink
        }
        .padding(.horizontal, 16)
        .onAppear {
            viewModel.loadLinksFromUserDefault()
        }
    }
    
    var navigationBar: some View {
        HStack {
            Spacer()
            
            Text("Your links")
            .font(.system(
                size: 30,
                weight: .bold,
                design: .serif)
            )
            .padding(.leading)
            Spacer()
            
            Button {
                withAnimation {
                    deleteLink.toggle()
                }
            } label: {
                Group {
                    deleteLink ?
                    AnyView(Text("Cancel"))
                    :
                    AnyView(Image(systemName: "square.and.pencil"))
                }
                .font(.system(
                    size: 22,
                    weight: .semibold,
                    design: .serif)
                )
                .foregroundStyle(Color(.label))
            }
        }
        .padding(.bottom, 20)
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
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading,spacing: 12) {
                ForEach(viewModel.links) { link in
                    LinkView(viewModel: viewModel, deleteLink: $deleteLink, links: link)
                }
            }
        }
    }
    
    var buttonAddLink: some View {
        Button(action: {
            viewModel.onEvent?(.openSheet)
        }) {
            Text("Add Link")
        }
        .buttonStyle(CustomButtonStyle(backgroundColor: .black, textColor: .white))
        .padding(.bottom)
    }
}


#Preview {
    AddLinksView(viewModel: AddLinksViewModel())
}
