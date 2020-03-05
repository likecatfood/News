//
//  ArticleLoadingView.swift
//  test
//
//  Created by Antony Starkov on 26.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import SwiftUI

struct ArticleLoadingView: View {
    
    @State private var angle: Double = 0
    @State private var borderThickness: CGFloat = 1
    @State private var offset: CGFloat = 10
    @State private var opacity: Double = 0.3

    
    var body: some View {
        HStack(spacing: 8) {
            ImagePlaceholder()
            VStack(alignment: .leading, spacing: 5.0) {
                Rectangle()                .foregroundColor(Color(.lightGray))
                    .padding(.top)
                    .padding(.bottom, 8)

                Rectangle()                .foregroundColor(Color(.lightGray))
                    .padding(.bottom, 8)


            }
        }.padding(.trailing)
            .frame(height: 120)
    }
}

struct ImagePlaceholder: View {
    var body: some View {
        Circle().frame(width: 100).foregroundColor(Color(.lightGray))
    }
}

struct ArticleLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleLoadingView()
    }
}
