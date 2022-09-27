//
//  MovieStore.swift
//  LazyGrid
//
//  Created by Kim Yewon on 2022/09/21.
//

import Foundation

struct MovieResponse: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
}

struct Movie: Decodable {
    let imdbID: String
    let title: String
    let poster: String
    
    private enum CodingKeys: String, CodingKey {
        case imdbID
        case title = "Title"
        case poster = "Poster"
    }
}

class MovieStore: ObservableObject {
    
    @Published var movies: [Movie]? = [Movie]()
    
    func getAll() {
        
        guard let url = URL(string: "http://www.omdbapi.com/?s=Ring&apikey=ed9a8be7") else { fatalError("Invalid URL") }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
            if let movieResponse = movieResponse {
                DispatchQueue.main.async {
                    self.movies = movieResponse.movies
                }
            }
            
        }.resume()
    }
    
}
