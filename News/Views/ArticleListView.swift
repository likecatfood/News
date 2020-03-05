//
//  ArticleListView.swift
//  test
//
//  Created by Antony Starkov on 04.03.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import SwiftUI

struct ArticleListView: View {
    @EnvironmentObject var cache: ImageCache
    let articles: [ArticleViewModel]

    var body: some View {
        ForEach(articles) { article in
              NavigationLink(destination: ArticleDetailsView(article: article, cache: self.cache))  {
                ArticleView(article: article)
              }.listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12.0))
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: [])
    }
}
