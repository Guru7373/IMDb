//
//  RestAPIManager.swift
//  IMDb
//
//  Created by Karthi CK on 27/02/22.
//

import UIKit

struct MovieDBAPI: MovieDataSource {

    private let baseUrl = "https://api.themoviedb.org/3/%@?api_key=%@&query=%@&page=%@"
    private let apiKey = "7e588fae3312be4835d4fcf73918a95f"
    
    func fetchMovies(completion: @escaping (Error?, MovieListModel?) -> ()) {
        fetchRequest(path: "search/movie") { (error, data) in
            let movieListModel = try? JSONDecoder().decode(MovieListModel.self, from: data ?? Data())
            completion(error, movieListModel)
        }
    }
    
    private func fetchRequest(path: String, completion: @escaping (Error?, Data?) -> ()) {
        let query = "a ".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "" as CVarArg
        let page = "01"
        guard let url = URL(string: String(format: baseUrl, path, apiKey, query, page))
        else {
            print("Invalid URL.")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            completion(error, data)
        }
        
        dataTask.resume()
    }
}
