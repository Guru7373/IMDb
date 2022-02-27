//
//  ListMoviesViewController.swift
//  IMDb
//
//  Created by Karthi CK on 27/02/22.
//

import UIKit

var likedMoviesID = [Int]()

class ListMoviesViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    let viewModel = MovieListCellViewModel(dataSource: MovieDBAPI())
    
    private let refreshControl = UIRefreshControl()
    private var selectedIndexPath: IndexPath?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (likedMoviesID.count > 0) {
            self.moviesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesTableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        moviesTableView.refreshControl = refreshControl
        
        bindViewModel()
        viewModel.fetchData()
    }

    @objc
    private func refreshData() {
        viewModel.fetchData()
    }
    
    private func bindViewModel() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.moviesTableView.reloadData()
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController,
           let cell = sender as? MovieListTableViewCell,
           let indexPath = moviesTableView?.indexPath(for: cell),
           let movieDetail = viewModel.getCellData(at: indexPath) {
            vc.movieDetail = movieDetail
        }
    }
}

extension ListMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID", for: indexPath) as! MovieListTableViewCell
        
        let movieData = viewModel.getCellData(at: indexPath)
        cell.movieNameLabel.text = movieData?.title
        cell.movieOveriewLabel.text = movieData?.overview
        cell.movieReleaseDateLabel.text = "Release Date: \(movieData?.releaseDate ?? "N/A")"
        cell.moviePopularityLabel.text = "\tPopularity: \(movieData?.popularity ?? 0.0)"
        
        if (likedMoviesID.contains(movieData?.id ?? -1)) {
            cell.watchListFlag.isHidden = false
            cell.watchListFlag.tintColor = .systemPink
            cell.watchListFlag.image = UIImage(systemName: "heart.fill")
        } else {
            cell.watchListFlag.isHidden = true
        }
        
        return cell
    }
    
}
