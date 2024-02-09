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
                    .task {
                        do {
                            try await writeDownViewModel.load()
                        } catch {
                            print("\(error)")
                        }
                    }
                    .listStyle(PlainListStyle())
                   
                    Button(action: {
                        viewModel.onEvent?(.openSheet)
                    }) {
                        Text("Let’s start surfing the web")
                    }
                    .buttonStyle(CustomButtonStyle(backgroundColor: .black, textColor: .white))
                    .padding(.bottom)
                }.background(Color(red: 242/255, green: 242/255, blue: 238/255))
    }
}


#Preview {
    AddLinksView(viewModel: AddLinksViewModel(), writeDownViewModel: WriteDownInfoViewModel())
}
