//
//  MovieDetailsEntity.swift
//  movie
//
//  Created by dan on 11.03.2023.
//

import Foundation


class MovieDetailsEntity: Decodable {
//    let genres: [Genre]
    let overview: String
//    let tagLine: String
    let title: String
    let posterPath: String
    let voteAverage: Double
    let tagline: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case tagline
    }
}
