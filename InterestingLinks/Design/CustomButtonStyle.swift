//
//  CustomButtonStyle.swift
//  InterestingLinks
//
//  Created by Alibek Shakirov on 08.02.2024.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    var backgroundColor: Color
    var textColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(configuration.isPressed ? Color.gray : backgroundColor)
            )
            .foregroundColor(textColor)
            .font(.system(
                size: 18,
                weight: .semibold,
                design: .serif)
            )
    }
}
