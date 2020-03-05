//
//  Article.swift
//  test
//
//  Created by Antony Starkov on 25.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let content: String?
}

