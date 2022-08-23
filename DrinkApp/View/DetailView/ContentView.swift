//
//  ContentView.swift
//  DrinkApp
//
//  Created by Mehran on 5/29/1401 AP.
//

import SwiftUI

struct ContentView: View {
    
    let geoSize: CGSize
    var data : DrinkDetail_Response
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                if let firstRow = data.getInstructions(), firstRow.count > 0 {
                    Text(AppConstant.Statement.instructions)
                        .modifier(TitleModifier())
                    ForEach(firstRow, id: \.self) { instructions in
                        RowData(data: instructions)
                    }
                    .padding(.top)
                }
                if let secondRow = data.getIngredients(), secondRow.count > 0 {
                    Text(AppConstant.Statement.ingredient)
                        .modifier(TitleModifier())
                    ForEach(secondRow, id: \.self) { ingredient in
                        RowData(data: ingredient)
                    }
                    .padding(.top)
            }
                    Spacer()
            }
            .padding(.horizontal)
        }
        .frame(width: geoSize.width)
    }
}
