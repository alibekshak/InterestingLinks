//
//  AddLinksView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct AddLinksView: View {
    
    @StateObject var viewModel: AddLinksViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 242/255, green: 242/255, blue: 238/255)
                
                TitleView(width: geometry.size.width, height: geometry.size.height, title: "Links App")
                
                VStack {
                    Spacer()
                    TextAddLinksView()
                    
                    Spacer()
                   
                    Button(action: {
                        
                    }) {
                        Text("Let’s start surfing the web")
                    }
                    .buttonStyle(CustomButtonStyle(backgroundColor: .black, textColor: .white))
                    .padding(.bottom)
                }
                .padding(.bottom)
                
            }
            .ignoresSafeArea()
        }
    }
}


#Preview {
    AddLinksView(viewModel: AddLinksViewModel())
}
