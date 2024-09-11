//
//  ListOfLinksView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 09.02.2024.
//

import SwiftUI

struct ListOfLinksView: View {
    
    @StateObject var viewModel: AddLinksViewModel
    
    @Binding var deleteLink: Bool
    
    let links: Links
    
    @State private var showingAlert = false
    
    var body: some View {
        Button {
            if let url = URL(string: links.link), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { success in
                    if !success {
                        self.showingAlert = true
                    }
                }
            } else {
                self.showingAlert = true
            }
        } label: {
            HStack(spacing: 16) {
                Text(links.name)
                    .font(.system(
                        size: 22,
                        weight: .semibold,
                        design: .serif)
                    )
                Spacer()
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                if deleteLink {
                    Button {
                        withAnimation {
                            viewModel.removeLink(links)
                            deleteLink.toggle()
                        }
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(Color(.red))
                            .font(.system(
                                size: 22,
                                weight: .semibold,
                                design: .serif)
                            )
                    }
                }

            }
            .foregroundColor(.black)
            .padding()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Некорректная ссылка"), dismissButton: .default(Text("Ок")))
        }
    }
}

#Preview {
    var links = Links.sampleData[0]
    return ListOfLinksView(viewModel: AddLinksViewModel(), deleteLink: .constant(true), links: links)
}
