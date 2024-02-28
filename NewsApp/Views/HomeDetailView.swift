//
//  HomeDetailView.swift
//  NewsApp
//
//  Created by Nurasyl Nurtaza on 27.02.2024.
//

import SwiftUI

struct HomeDetailView: View {
    let news: Article
    init(_ news:Article){
        self.news = news
    }
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text("Author: \(news.author)")
                    .font(.headline)
                Text("Content: \(news.content)")
                    .font(.caption)
                Text("Description: \(news.description)")
                    .foregroundColor(.blue)
                    .font(.subheadline)
                    .padding(.bottom, 5)
                Text("Link: \(news.url)")
            }
            .font(Font.system(.body, design: .monospaced))
            .padding()
            .navigationTitle(news.title)
        }
}

#Preview {
    HomeDetailView(Article(author: "author", title: "title", description: "desc", content: "content", url: "url", urlToImage: "image"))
}
