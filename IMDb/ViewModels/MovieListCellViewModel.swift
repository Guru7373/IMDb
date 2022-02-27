//
//  MovieListCellViewModel.swift
//  IMDb
//
//  Created by Karthi CK on 27/02/22.
//

import Foundation

protocol MovieDataSource {
    func fetchMovies(completion: @escaping (Error?, MovieListModel?) -> ())
}

class MovieListCellViewModel {
    
    var reloadTableView: (()->())?

    private var dataSource: MovieDataSource
        
    private var movies: [MovieResults?] = [MovieResults?]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    init(dataSource: MovieDataSource) {
        self.dataSource = dataSource
    }
    
    var numberOfMovies: Int {
        return movies.count
    }
    
    func getCellData(at indexPath: IndexPath) -> MovieResults? {
        return movies[indexPath.row]
    }
    
    func fetchData() {
        dataSource.fetchMovies { [weak self] error, moviesList in
            if let error = error {
                print(error)
            }
            if let movieList = moviesList?.results,
               movieList.count > 0 {
                self?.movies = movieList
            }
        }
    }
    
}
