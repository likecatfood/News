//
//  ContentView.swift
//  test
//
//  Created by Antony Starkov on 24.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var model = HomeViewModel(with: ArticleService())
    @State var showingDetail = false
        
    var body: some View {
        NavigationView {
            VStack {
                newsList
            }
            .navigationBarTitle(model.category.title)
            .navigationBarItems(trailing:
                HStack(alignment: .bottom, spacing: 12) {
                    searchButton
                    infoButton
                }
            )
        }
    }
    
    private var topDashboard: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            CategoriesGridView(categories: self.model.avaliableCategories, selectedCategory: self.$model.category).padding(.leading, 8)
        }
    }
    
    var newsList: some View {
        List {
            Section(header: topDashboard.background(Color(.systemBackground)).listRowInsets(EdgeInsets()))
            {
                if model.isLoading {
                    ForEach(0...10, id: \.self) { _ in
                        ArticleLoadingView().listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12.0))
                    }
                } else {
                    ArticleListView(articles: model.articles)
                }
            }
        }
    }
    
    private var searchButton: some View {
        NavigationLink(destination: SearchView())  {
          Image(systemName: "magnifyingglass")
        }
    }
    
    private var infoButton: some View {
        Button(action: {
            self.showingDetail = true
        }) {
            Image(systemName: "info.circle")
        }.sheet(isPresented: $showingDetail) {
            InfoView()
        }
    }
}

struct CategoriesGridView : View {
    var categories: [CategoryViewModel]
    @Binding var selectedCategory: CategoryViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle().frame(height: 1, alignment: .bottom).opacity(0.15)
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    HeaderTabButton(category: category, selectedCategory: self.$selectedCategory)
                }
            }

        }.padding([.leading, .trailing], 8)
    }
}

struct HeaderTabButton : View {
    var category: CategoryViewModel
    @Binding var selectedCategory: CategoryViewModel

    var isSelected: Bool {
        selectedCategory == category
    }

    var body: some View {
        Button(action: {
            if self.selectedCategory != self.category {
                self.selectedCategory = self.category
            }
        }) {
            VStack {
                Text(category.title)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.callout)
                    .frame(height: 30, alignment: .bottom)
                
                Rectangle()
                    .frame(height: 2, alignment: .bottom)
                    .foregroundColor(isSelected ? Color.accentColor : Color.clear)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

