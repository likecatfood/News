//
//  Article.swift
//  test
//
//  Created by Antony Starkov on 25.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import Foundation

struct Article: Codable, Equatable {
    var title: String = ""
    var description: String? = nil
    var url: String = ""
    var urlToImage: String? =  nil
    var content: String? = nil
}
