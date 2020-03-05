//
//  AsyncImage.swift
//  test
//
//  Created by Antony Starkov on 26.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    private let configuration: (Image) -> Image

    
    init(url: URL, placeholder: Placeholder? = nil, cache: ImageCache? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = placeholder
        self.configuration = configuration
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image: some View {
        Group {
            if loader.image != nil {
                configuration(Image(uiImage: loader.image!))
                    .aspectRatio(contentMode: .fill)
            } else {
                placeholder
            }
        }
    }
}
