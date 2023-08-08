//
//  NewsView.swift
//  NewsApp
//
//  Created by alex on 5/7/23.
//

import SwiftUI

struct NewsView: View {
    var newsManager = NewsManager()
    @State private var articles = [NewsResponse.Article]()
    @State private var isLoading = true
    @State private var selectedSegment = 0
    
    var filteredArticles: [NewsResponse.Article] {
        if selectedSegment == 0 {
            return articles
        } else {
            let sentiment = selectedSegment == 1 ? "Positive" : "Negative"
            return articles.filter { predictSentement(text: $0.title) == sentiment }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedSegment) {
                    Text("All News").tag(0)
                    Text("Good News").tag(1)
                    Text("Bad News").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                ScrollView {
                    if isLoading != true {
                        ForEach(filteredArticles) { article in
                            let type = predictSentement(text: article.title)
                            NavigationLink {
                                ArticleView(article: article)
                            } label: {
                                NewsCardComponent(article: article, type: type ?? "Neutral")
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
            .navigationTitle("News Feed")
            .preferredColorScheme(.dark)
            .onAppear {
                newsManager.getNews(category: "general") { newsResponse in
                    articles = newsResponse
                    isLoading = false
                }
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
