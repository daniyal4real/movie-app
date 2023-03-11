//
//  MovieDetailsViewController.swift
//  movie
//
//  Created by dan on 11.03.2023.
//

import UIKit
import Alamofire
import Kingfisher

class MovieDetailsViewController: UIViewController {

    
    var movieId: Int = 0
    private let MOVIE_DETAIL_URL: String = "https://api.themoviedb.org/3/movie/"
    private let API_KEY: String = "71c5f8ef30fef8f804a20450b817bb2b"
    
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        overviewLabel.textColor = .black
        overviewLabel.font = .systemFont(ofSize: 16, weight: .regular)
        overviewLabel.contentMode = .scaleToFill
        overviewLabel.numberOfLines = 0
        movieImage.layer.cornerRadius = 15
        movieImage.layer.masksToBounds = true
        getMovieById(movieId: movieId)
    }
    
    func getMovieById(movieId: Int) {
        let params: [String: Any] = ["api_key" : API_KEY]
        AF.request(MOVIE_DETAIL_URL + "\(movieId)", method: .get, parameters: params).responseJSON {(response) in
            switch response.result {
            case .success(_):
                do {
                    if let data = response.data {
                        let json = try JSONDecoder().decode(MovieDetailsEntity.self, from: data)
                        self.taglineLabel.text = json.tagline
                        self.overviewLabel.text = json.overview
                        let url = URL(string: "https://image.tmdb.org/t/p/w300\(json.posterPath)")
                        self.movieImage.kf.setImage(with: url)
                        let convertedRate = Double(round(10 * json.voteAverage) / 10)
                        self.ratingLabel.text = String(convertedRate)
//                        print("JSON!!! \(json)")
                    }
                }
                catch let movieError {
                    print(movieError)
                }
                print(response)
            case .failure(let error):
                print(error)
            }
        }
//        AF.request(MOVIE_DETAIL_URL + "/\(movieId)")
    }
}
