//
//  MovieDto.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

struct MovieDto: Decodable{
    let id: Int?
    let originalTitle: String?
    let posterPath: String?
    let backdropPath: String
    let voteAverage: Double?
    let releaseDate: String?
    let genreIds: [Int]?
}

struct MovieResponse: Decodable {
    let page: Int
    let results: [MovieDto]
}
