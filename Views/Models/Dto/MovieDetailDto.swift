//
//  MovieDetail.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

struct MovieDetailDto: Decodable {
    let id: Int?
    let posterPath: String?
    let backdropPath: String?
    let runtime: Int?
    let title: String?
    let tagline: String?
    let voteAverage: Double?
    let releaseDate: String?
    let overview: String?
    let genres: [GenreDto]?
    let productionCompanies: [ProductionCompanyDto]?

    typealias Genre = (id: Int, name: String)

    static let mock = MovieDetailDto(
        id: 1,
        posterPath: "/aosm8NMQ3UyoBVpSxyimorCQykC.jpg",
        backdropPath: "/3V4kLQg0kSqPLctI5ziYWabAZYF.jpg",
        runtime: 109,
        title: "Sombras en el paraíso",
        tagline: "La sombra más oscura",
        voteAverage: 6.9,
        releaseDate: "2024-11-21",
        overview:
            "Five years after surviving Art the Clown's Halloween massacre, Sienna and Jonathan are still struggling to rebuild their shattered lives. As the holiday season approaches, they try to embrace the Christmas spirit and leave the horrors of the past behind. But just when they think they're safe, Art returns, determined to turn their holiday cheer into a new nightmare. The festive season quickly unravels as Art unleashes his twisted brand of terror, proving that no holiday is safe.",
        genres: [
            .init(id: 28, name: "Action"), .init(id: 12, name: "Adventure"),
            .init(id: 14, name: "Fantasy"), .init(id: 10751, name: "Romance"),
            .init(id: 10752, name: "Sci-Fi"),
        ],
        productionCompanies: [
            .init(
                id: 1, logoPath: "/jLAg5fOlAw1Jl8Q7WoyKxh1H22y.png",
                name: "Universal Pictures"),
            .init(
                id: 2, logoPath: "/yezzLb9RbKNtQUsyYySAqC9TQr7.png",
                name: "Walt Disney Pictures"),
        ]
    )

    static let empty: MovieDetailDto = MovieDetailDto(
        id: 0,
        posterPath: "",
        backdropPath: "",
        runtime: 0,
        title: "",
        tagline: "",
        voteAverage: 0,
        releaseDate: "",
        overview: "",
        genres: [],
        productionCompanies: []
    )
}
