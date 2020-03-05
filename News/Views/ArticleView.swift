//
//  ArticleView.swift
//  test
//
//  Created by Antony Starkov on 25.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import SwiftUI

struct ArticleView: View {
    @EnvironmentObject var cache: ImageCache
    var article: ArticleViewModel
    
    var body: some View {
        HStack(spacing: 8) {
            if article.imageUrl != nil {
                articleImage
            } else {
                ImagePlaceholder()
            }
            VStack(alignment: .leading, spacing: 5.0) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text(article.description)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
                    //.frame(height: 40)
            }
        }.padding(.trailing)
            .frame(height: 120)
    }
    
    private var articleImage: some View {
         AsyncImage(url: article.imageUrl!, placeholder: ImagePlaceholder(), cache: self.cache, configuration: {
            $0.resizable()
            }).frame(width: 100, height: 100, alignment: .leading).clipShape(Circle())
    }
}

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleView(title: "В Москве полицейские изъяли самодельный «бэтмобиль». Водитель ездил на нём по городу", description: "Габариты машины превышают допустимые нормы. Габариты машины превышают допустимые нормы. Габариты машины превышают допустимые нормы. Габариты машины превышают допустимые нормы.", imageUrl: "https://leonardo.osnova.io/ef2b7a03-7d94-3dd4-36b0-df04ec602f3a/-/resize/1200/", cache: TemporaryImageCache())
//    }
//}
