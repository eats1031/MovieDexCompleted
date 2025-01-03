//
//  Movie.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

struct Movie {
    let id: Int
    let originalTitle: String
    let posterPath: String
    let backdropPath: String
    let voteAverage: Double
    let releaseDate: String
    let genreIds: [Int]
    var genresList: String = ""
    
    init(dto: MovieDto){
        self.id = dto.id ?? 0
        self.originalTitle = dto.originalTitle ?? "No Title"
        self.posterPath = dto.posterPath ?? ""
        self.backdropPath = dto.posterPath ?? ""
        self.voteAverage = dto.voteAverage ?? 0
        self.releaseDate = dto.releaseDate ?? ""
        self.genreIds = dto.genreIds ?? []
    }
    
    var releaseDateFormatted: String {
        self.releaseDate.toShortDateFormat()
    }
}
