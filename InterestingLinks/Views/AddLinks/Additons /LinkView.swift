//
//  LinkView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 09.02.2024.
//

import SwiftUI

struct LinkView: View {
    
    @StateObject var viewModel: AddLinksViewModel
    
    @Binding var deleteLink: Bool
    
    let links: Links
    
    
    var body: some View {
        Button {
            viewModel.checkLink(link: links.link)
        } label: {
            VStack(spacing: 12) {
                HStack(spacing: 16) {
                    Text(links.name)
                    Spacer()
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    
                    if deleteLink {
                        deleteButton
                    }
                }
                .font(.system(
                    size: 22,
                    weight: .semibold,
                    design: .serif)
                )
                .foregroundColor(.black)
                .padding()
                
                Divider()
            }
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Некорректная ссылка"), dismissButton: .default(Text("Ок")))
        }
        
    }
    
    var deleteButton: some View {
        Button {
            withAnimation {
                viewModel.removeLink(links)
                viewModel.saveLinksToUserDefault()
                deleteLink.toggle()
            }
        } label: {
            Image(systemName: "trash.fill")
                .foregroundStyle(Color(.red))
        }
    }
}

#Preview {
    var links = Links.sampleData[0]
    return LinkView(viewModel: AddLinksViewModel(), deleteLink: .constant(true), links: links)
}
