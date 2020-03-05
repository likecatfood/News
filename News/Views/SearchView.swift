//
//  SearchView.swift
//  test
//
//  Created by Antony Starkov on 03.03.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject private var model = SearchViewModel()

    var body: some View {
        VStack {
            List {
                searchBar.listRowInsets(EdgeInsets())
                ArticleListView(articles: model.articles)
            }
            .navigationBarTitle(Text("Search"))
            .resignKeyboardOnDragGesture()
        }
    }
    
    var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("search", text: $model.searchText, onEditingChanged: { isEditing in
                    self.model.showCancelButton = true
                }, onCommit: {
                    self.model.load()
                    UIApplication.shared.endEditing(true)
                    self.model.showCancelButton = false
                }).foregroundColor(.primary).keyboardType(.webSearch)

                Button(action: {
                    self.model.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(model.searchText == "" ? 0.0 : 1.0)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)

            if model.showCancelButton  {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    self.model.searchText = ""
                    self.model.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(model.showCancelButton).animation(.default) // animation does not work properly
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

private struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged { _ in
        UIApplication.shared.endEditing(true)
    }
    
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

private extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
