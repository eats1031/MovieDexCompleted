//
//  Endpoints.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

enum Endpoints {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w780"
    static let language = "en"
    static private var apiKey: String {
        guard
            let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY")
                as? String
        else {
            return ""
        }

        return apiKey
    }

    case popularMovies(page: Int)
    case movieDetails(id: Int)
    case remoteImage(path: String)
    case trailers(id: Int)
    case genres

    var url: String {
        switch self {
        case .popularMovies(let page):
            return
                "\(Endpoints.baseURL)/movie/popular?api_key=\(Endpoints.apiKey)&language=\(Endpoints.language)&page=\(page)"
        case .movieDetails(let id):
            return
                "\(Endpoints.baseURL)/movie/\(id)?api_key=\(Endpoints.apiKey)&language=\(Endpoints.language)"
        case .remoteImage(let path):
            return
                "\(Endpoints.imageBaseURL)/\(path)?api_key=\(Endpoints.apiKey)&language=\(Endpoints.language)"
        case .trailers(let id):
            return
                "\(Endpoints.baseURL)/movie/\(id)/videos?api_key=\(Endpoints.apiKey)&language=\(Endpoints.language)"
        case .genres:
            return
                "\(Endpoints.baseURL)/genre/movie/list?api_key=\(Endpoints.apiKey)&language=\(Endpoints.language)"
        }
    }
}
