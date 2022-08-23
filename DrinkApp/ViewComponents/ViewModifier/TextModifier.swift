//
//  TextModifier.swift
//  DrinkApp
//
//  Created by Mehran Kamalifard on 8/21/22.
//

import SwiftUI

struct TextModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .medium, design: .rounded))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color(UIColor.fontWhiteColor))
            .padding(.leading, 30)
    }
}
