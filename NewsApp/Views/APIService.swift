//
//  APIService.swift
//  NewsApp
//
//  Created by Nurasyl Nurtaza on 29.02.2024.
//

import Foundation
func getNews() async throws -> ([Article], [Article]) {
    let key = "25db065134d44a4c93b9c67482aa894f"
    let everythingURL = "https://newsapi.org/v2/everything?q=apple&apiKey=\(key)"
    let headlinesURL = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=\(key)"
    
    guard let everythingURL = URL(string: everythingURL), let headlinesURL = URL(string: headlinesURL) else {
        throw URLError(.badURL)
    }
    
    let everythingRequest = URLRequest(url: everythingURL)
    let headlinesRequest = URLRequest(url: headlinesURL)
    
    do {
        let (everythingData, _) = try await URLSession.shared.data(for: everythingRequest)
        let (headlinesData, _) = try await URLSession.shared.data(for: headlinesRequest)
        if let everythingJSONString = String(data: everythingData, encoding: .utf8) {
            print("Everything JSON Response:", everythingJSONString)
        }
        
        if let headlinesJSONString = String(data: headlinesData, encoding: .utf8) {
            print("Headlines JSON Response:", headlinesJSONString)
        }
        let decoder = JSONDecoder()
        let everythingResponse = try decoder.decode(Response.self, from: everythingData).articles
        let headlinesResponse = try decoder.decode(Response.self, from: headlinesData).articles
        
        
        return (headlinesResponse, everythingResponse)
    } catch {
        print("Error fetching or decoding data: \(error)")
        throw error
    }
}
