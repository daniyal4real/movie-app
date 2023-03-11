//
//  TrendingMoviesEntity.swift
//  movie
//
//  Created by dan on 06.03.2023.
//

import Foundation


class TrendingMoviesEntity: Decodable {
    let results: [Movie]
    
    class Movie: Decodable {
        let id: Int
        let originalTitle: String
        let releaseDate: String
        let voteAverage: Double
        let posterPath: String?
        
        func getOriginalTitle() -> String {
            return self.originalTitle
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case originalTitle = "original_title"
            case releaseDate = "release_date"
            case voteAverage = "vote_average"
            case posterPath = "poster_path"
        }
    }
}
