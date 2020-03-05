//
//  CategoryView.swift
//  test
//
//  Created by Antony Starkov on 26.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    
    var text: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.yellow)
                .cornerRadius(15)
                .frame(height: 50)
            .blur(radius: 5)
            
            Text(text).lineLimit(1)
        }
//        .padding(.leading)
//        .padding(.trailing)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(text: "BBC News")
    }
}
