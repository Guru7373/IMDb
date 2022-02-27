//
//  MovieListModal.swift
//  IMDb
//
//  Created by Karthi CK on 27/02/22.
//

import Foundation

struct MovieListModel: Codable {
    
    let results: [MovieResults?]?
    
}

struct MovieResults: Codable {
    
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, overview, popularity, id
        case voteCount = "vote_count"
    }
    
}
