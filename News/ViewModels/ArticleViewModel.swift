//
//  ArticleViewModel.swift
//  test
//
//  Created by Antony Starkov on 26.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation

final class ArticleViewModel: Identifiable {
    
    let id = UUID()
    
    private let entity: Article
    
    init(article: Article) {
        self.entity = article
    }
    
    var title: String { return entity.title }
    var description: String { return entity.description ?? "" }
    var content: String { return entity.content ?? "" }
    var sourceUrl: URL  { return URL(string: entity.url) ?? URL(string: "")! }
    var imageUrl: URL?  {
        if let imgUrlString = entity.urlToImage {
            return URL(string: imgUrlString)
        }
        return nil

    }
}
