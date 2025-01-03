//
//  MovieDetail.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

class MovieDetail {
    let id: Int
    let posterPath: String
    let backdropPath: String
    let title: String
    let tagline: String
    let voteAverage: Double
    let runtime: Int
    let releaseDate: String
    let overview: String
    let genres: [Genre]
    let productionCompanies: [ProductionCompany]

    init(dto: MovieDetailDto) {
        self.id = dto.id ?? 0
        self.posterPath = dto.posterPath ?? ""
        self.backdropPath = dto.backdropPath ?? ""
        self.title = dto.title ?? "No title"
        self.tagline = dto.tagline ?? ""
        self.voteAverage = dto.voteAverage ?? 0
        self.runtime = dto.runtime ?? 0
        self.releaseDate = dto.releaseDate ?? ""
        self.overview = dto.overview ?? ""
        self.genres = dto.genres?.map{genre in Genre(dto: genre)} ?? []
        self.productionCompanies = dto.productionCompanies?.map{company in ProductionCompany(dto: company)} ?? []
    }

    var duration: String {
        return "\(self.runtime/60)h \(self.runtime%60)m"
    }
    
    var releaseMonthYear: String {
        return self.releaseDate.toMonthYearFormat()
    }
    
    var genresString: String {
        return self.genres.map{genre in genre.name}.joined(separator: ", ")
    }
    
    var logosFromProductionCompanies: [String] {
        let companies = self.productionCompanies.compactMap{company in company.logoPath}
        return companies.isEmpty ? [] : companies
    }
}
