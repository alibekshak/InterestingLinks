//
//  CustomTextField.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 11.07.2024.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text)
            .textFieldStyle(.plain)
            .multilineTextAlignment(.leading)
            .accentColor(.black)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.gray.opacity(0.2))
            }
            .font(.system(
                size: 16,
                weight: .regular,
                design: .serif)
            )
    }
}

#Preview {
    CustomTextField(title: "Link", text: .constant(""))
}
