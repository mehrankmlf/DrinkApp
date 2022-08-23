//
//  TitleModifier.swift
//  DrinkApp
//
//  Created by Mehran Kamalifard on 8/21/22.
//

import SwiftUI

struct TitleModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color(UIColor.fontWhiteColor))
            .padding(.leading, 10)
            .padding(.top)
    }
}
