//
//  SpinnerViewHandler.swift
//  DrinkApp
//
//  Created by Mehran Kamalifard on 8/22/22.
//

import SwiftUI

struct SpinnerViewHandler: View {
    
    let geoSize: CGSize
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                SpinnerViewIndicator(isAnimating: $isShowing, style: .large)
            }
            .frame(width: geoSize.width,
                   height: geoSize.height)
            .background(Color(UIColor.activityIndicatorColor))
            .opacity(self.isShowing ? 1 : 0)

        }
    }
}
