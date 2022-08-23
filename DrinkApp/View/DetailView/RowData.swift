//
//  RowData.swift
//  DrinkApp
//
//  Created by Mehran on 5/30/1401 AP.
//

import SwiftUI

struct RowData: View {
    
    var data : String
    
    var body: some View {
        VStack(spacing : 5) {
            Text(data)
                .modifier(TextModifier())
        }
    }
}
