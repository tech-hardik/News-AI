//
//  ArticleView.swift
//  NewsApp
//
//  Created by alex on 5/7/23.
//

import SwiftUI
import Kingfisher

struct ArticleView: View {
    var article: NewsResponse.Article
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text(article.title)
                        .font(.title2)
                        .bold()
                    
                    KFImage(URL(string: article.urlToImage ?? ""))
                        .resizable()
                        .scaledToFill()
                    
                    Text(article.content ?? "")
                        .padding(.horizontal)
                        .font(.body)
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: NewsResponse.Article(title: "", url: ""))
    }
}
