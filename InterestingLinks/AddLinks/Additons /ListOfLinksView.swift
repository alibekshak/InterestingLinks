//
//  ListOfLinksView.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 09.02.2024.
//

import SwiftUI

struct ListOfLinksView: View {
    
    let links: Links
    
    var body: some View {
        HStack {
            Text(links.name)
                .font(.title)
            Spacer()
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .resizable()
                .frame(width: 24, height: 24)
        }
        .foregroundColor(.black)
        .padding()
        .onTapGesture {
            if let url = URL(string: links.link) {
                UIApplication.shared.open(url)
            }
        }
    }
}

#Preview {
    var links = Links.sampleData[0]
    return ListOfLinksView(links: links)
}
