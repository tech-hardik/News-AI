//
//  SearchView.swift
//  NewsApp
//
//  Created by alex on 5/7/23.
//

import SwiftUI

struct SearchView: View {
    var newsManager = NewsManager()
    @State private var selectedGenre = "general"
    @State private var isLoading = true
    @State private var searchText = ""
    @State private var articles = [NewsResponse.Article]()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search...", text: $searchText)
                        .padding(.leading, 20)
                    
                    if searchText.isEmpty {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                    } else {
                        Button {
                            searchText = ""
                            updateNewsArticles()
                        } label: {
                            Image(systemName: "xmark.cicrcle.fill")
                                .foregroundColor(.gray)
                                .padding(.leading, 8)
                        }

                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                if searchText == "" {
                    Picker("Picker", selection: $selectedGenre) {
                        Text("General").tag("general")
                        Text("Business").tag("business")
                        Text("Entertainment").tag("entertainment")
                        Text("Sports").tag("sports")
                        Text("Science").tag("science")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 15)
                }
                
                ScrollView {
                    if isLoading != true {
                        ForEach(articles) { article in
                            let type = predictSentement(text: article.title)
                            NavigationLink {
                                ArticleView(article: article)
                            } label: {
                                NewsCardComponent(article: article, type: type ?? "Neutral")
                            }
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
            .onAppear(perform: updateNewsArticles)
            .onChange(of: selectedGenre) { _ in
                isLoading = true
                updateNewsArticles()
            }
            .onChange(of: searchText) { _ in
                isLoading = true
                updateNewsArticlesFromSearch()
            }
        }
    }
    
    private func updateNewsArticles() {
        newsManager.getNews(category: selectedGenre) { newsResponse in
            articles = newsResponse
            isLoading = false
        }
    }
    
    private func updateNewsArticlesFromSearch() {
        newsManager.getNewsFromSearch(search: searchText) { newsResponse in
            articles = newsResponse
            isLoading = false
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
