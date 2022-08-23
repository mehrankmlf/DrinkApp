//
//  HeaderView.swift
//  DrinkApp
//
//  Created by Mehran on 5/29/1401 AP.
//

import SwiftUI

struct HeaderView: View {
    
    let geoSize: CGSize
    var url : URL
    var name : String
    
    var body: some View {
        
        ZStack {
            VStack {
                AsyncImage(
                    url: url,
                    placeholder: { Text("Loading ...") },
                    image: { Image(uiImage: $0)
                        .resizable() })
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 30)
                
                Text(name)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color(UIColor.fontYellowColor))
                    .padding(.top, 10)
                
                Spacer()
            }
        }
        .frame(width: geoSize.width, height: 300, alignment: .center)
        .background(Color(UIColor.darkBackground))
        .cornerRadius(30, corners: [.bottomRight, .bottomLeft])
    }
}

