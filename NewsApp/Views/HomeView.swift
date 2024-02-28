//
//  HomeView.swift
//  NewsApp
//
//  Created by Nurasyl Nurtaza on 27.02.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
struct Article: Codable, Hashable{
    let author: String
    let title: String
    let description: String
    let content: String
    let url: String
    let urlToImage: String?

}
struct Response:Codable{
    let articles:[Article]
}

struct HomeView: View {
    @State private var dat: [Article] = []
    @State private var dat1: [Article] = []
    var body: some View {
        TabView{
            NavigationView{
                List(dat, id:\.self){
                    news in NavigationLink(destination: HomeDetailView(news)){
                        Text(news.title)
                        if let imageUrl = news.urlToImage {
                                        AsyncImage(url: URL(string: imageUrl)) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image.resizable().scaledToFit()
                                            case .failure(let error):
                                                Text("Failed to load image: \(error.localizedDescription)")
                                            case .empty:
                                                Text("Loading...")
                                            @unknown default:
                                                Text("Unknown state")
                                            }
                                        }
                                        .frame(width: 100, height: 100)                                     } else {
                                        Text("No Image")
                                    }
                        
                    }
                }.navigationTitle("Headlines")
            }
            .tabItem { Label("Headlines", systemImage: "book.closed") }
            NavigationView{
                List(dat1, id: \.self) {news in
                    NavigationLink(destination: HomeDetailView(news)){
                        Text(news.title)
                        if let imageUrl = news.urlToImage {
                            AsyncImage(url: URL(string: imageUrl)) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable().scaledToFit()
                                case .failure(let error):
                                    Text("Failed to load image: \(error.localizedDescription)")
                                case .empty:
                                    Text("Loading...")
                                @unknown default:
                                    Text("Unknown state")
                                }
                            }
                            .frame(width: 100, height: 100)
                        } else {
                            Text("No Image")
                        }
                    }
                }
                .navigationTitle("Everything")
            }
            .tabItem { Label("Everything", systemImage: "book.closed.fill") }
        } .task{
            do{
                (dat, dat1) = try await getNews()
            }catch{
                print("Error fetching data: \(error)")
            }
        }
        .onReceive(Timer.publish(every: 5, on: .main, in: .common).autoconnect()){ _ in
            Task{
                do{
                    (dat, dat1) = try await getNews()
                }catch{
                    print("Error fetching data: \(error)")
                }
            }
        }
        
    }

    
}

#Preview {
    HomeView()
}
