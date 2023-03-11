//
//  TrendingMoviesViewController.swift
//  movie
//
//  Created by dan on 06.03.2023.
//

import UIKit
import Alamofire
import Kingfisher


class TrendingMoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var currentPage: Int = 1
    private var movies: [TrendingMoviesEntity.Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let TRENDING_MOVIES_URL: String = "https://api.themoviedb.org/3/trending/movie/week"
    private let API_KEY: String = "71c5f8ef30fef8f804a20450b817bb2b"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Trending"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MovieCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: MovieCell.identifier)
        getTrendingMovies()
    }
    
    func getTrendingMovies(page: Int? = nil) {
        var params: [String: Any] = ["api_key": API_KEY]
        if let page = page {
            params["page"] = page
        }
        AF.request(TRENDING_MOVIES_URL, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(_):
                do {
                    if let data = response.data {
                        let json = try JSONDecoder().decode(TrendingMoviesEntity.self, from: data)
                        self.movies = self.movies + json.results
                    }
                }
                catch let movieError {
                    print(movieError)
                }
//                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 10 && scrollView.contentOffset.y > 200 {
            currentPage += 1
            getTrendingMovies(page: currentPage)
        }
    }
}





//
extension TrendingMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let movieDetailsVC = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            movieDetailsVC.title = movies[indexPath.row].originalTitle
            movieDetailsVC.movieId = movies[indexPath.row].id
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
}


//
extension TrendingMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(movie.posterPath ?? "")")
        cell.originalTitleLabel.text = movie.originalTitle
        let convertedRate = Double(round(10 * movie.voteAverage) / 10)
        cell.overallRatingLabel.text = String(convertedRate)
        cell.releaseDateLabel.text = movie.releaseDate
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}
