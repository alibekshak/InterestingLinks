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
    
    @State var alertOnDelete: Bool = false
    
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
                        .alert(isPresented: $viewModel.showingAlert) {
                            Alert(title: Text("Incorrect link"), dismissButton: .default(Text("Ok")))
                        }
                    
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
    }
    
    var deleteButton: some View {
        Button {
            withAnimation {
                alertOnDelete.toggle()
            }
        } label: {
            Image(systemName: "trash.fill")
                .foregroundStyle(Color(.red))
        }
        .alert(isPresented: $alertOnDelete) {
            Alert(
                title: Text("Are you sure you want to delete the selected link ?"),
                primaryButton: .destructive(Text("Delete")) {
                    viewModel.removeLink(links)
                    deleteLink.toggle()
                },
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
    
}

#Preview {
    var links = Links.sampleData[0]
    return LinkView(viewModel: AddLinksViewModel(), deleteLink: .constant(true), links: links)
}
