//
//  MovieDetailViewController.swift
//  IMDb
//
//  Created by Karthi CK on 27/02/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var addToWatchListButtonItem: UIBarButtonItem!

    @IBOutlet weak var movieOriginalTitleLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    var movieDetail: MovieResults!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movie Detail"
        
        bindData()
    }

    private func bindData() {
        movieOriginalTitleLabel.text = movieDetail.originalTitle
        movieTitleLabel.text = movieDetail.title
        overViewLabel.text = movieDetail.overview
        popularityLabel.text = "\(movieDetail.popularity ?? 0.0)"
        releaseDateLabel.text = movieDetail.releaseDate
        voteCountLabel.text = "\(movieDetail.voteCount ?? 0)"
        
        if (likedMoviesID.contains(movieDetail.id ?? -1)) {
            addToWatchListButtonItem.image = UIImage(systemName: "heart.fill")
            addToWatchListButtonItem.tintColor = .systemPink
        } else {
            addToWatchListButtonItem.image = UIImage(systemName: "heart")
            addToWatchListButtonItem.tintColor = .systemBlue
        }
    }
    
    @IBAction func addToWatchListAction(_ sender: UIBarButtonItem) {
        if (likedMoviesID.contains(movieDetail.id ?? -1)) {
            likedMoviesID.removeAll(where: { $0 == movieDetail.id ?? -1 })
            sender.image = UIImage(systemName: "heart")
            sender.tintColor = .systemBlue
        } else {
            likedMoviesID.append(movieDetail.id ?? -1)
            sender.image = UIImage(systemName: "heart.fill")
            sender.tintColor = .systemPink
        }
    }
    
}
