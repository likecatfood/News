//
//  RepoDetailsView.swift
//  test
//
//  Created by Antony Starkov on 25.02.2020.
//  Copyright © 2020 Antony Starkov. All rights reserved.
//

import SwiftUI

struct ArticleDetailsView: View {
    
    var article: ArticleViewModel
    var cache: ImageCache
    
    @State private var showSafari = false
    @State private var showShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                headline
                
                if !article.description.isEmpty {
                    desciprtion
                }
                
                if article.imageUrl != nil {
                    image
                }
                
                if !article.content.isEmpty {
                    content
                }
                
                moreButton
            }.padding()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing: shareButton)
    }
    
    private var headline: some View {
        Text(article.title)
            .foregroundColor(.primary)
            .font(.largeTitle)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
    }
    
    private var desciprtion: some View {
        Text(article.description)
            .foregroundColor(.primary)
            .font(.body)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .lineSpacing(12)
    }
    
    private var image: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: article.imageUrl!, placeholder: Text("Loading Image..."), cache: self.cache, configuration: { $0.resizable() }).aspectRatio(contentMode: .fit)
        }.listRowInsets(EdgeInsets())
    }
    
    private var content: some View {
        Text(article.content)
            .foregroundColor(.primary)
            .font(.body)
            .lineLimit(nil)
            .lineSpacing(8)
            .multilineTextAlignment(.leading)
    }
    
    private var moreButton: some View {
        HStack {
            Spacer()
            Button(action: {
                self.showSafari = true
            }) {
                Text("Read more")
            }
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            Spacer()
        }.padding(.top, 25)
        .sheet(isPresented: $showSafari) {
            SafariView(url: self.article.sourceUrl)
        }
    }
    
    private var shareButton: some View {
        Button(action: {
            self.showShareSheet = true
        }) {
            Image(systemName: "square.and.arrow.up")
        }.sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [self.article.sourceUrl])
        }
    }
}

//struct ArticleDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleDetailsView(article: Article(title: "Репортёр забыл отключить фильтры в трансляции Фейсбука. За эфир он побывал трансформером, волшебником и енотом", description: "Куда смотрел оператор, неизвестно.", url: "https://www.hackingwithswift.com", urlToImage: "https://p.bigstockphoto.com/GeFvQkBbSLaMdpKXF1Zv_bigstock-Aerial-View-Of-Blue-Lakes-And--227291596.jpg", content: "Телевизионный репортёр из Северной Каролины Джастин Хинтон (Justin Hinton) забыл отключить AR-фильтры в Фейсбуке, прежде чем запускать прямой эфир о первом снегопаде в городе Эшвилле. Об этом сообщает The New York Post.        20 февраля Хинтон, обладатель премии «Эмми» за лучший репортаж в прямом эфире, рассказал в трансляции о первом настоящем снегопаде. В этой местности редко встречаются обильные снегопады, поэтому репортёр предупреждал водителей о скользких дорогах, которые стоит избегать. Но ещё до включения прямого эфира корреспондент случайно нажал на кнопку с «Загадочными масками»."), cache: TemporaryImageCache())
//    }
//}
