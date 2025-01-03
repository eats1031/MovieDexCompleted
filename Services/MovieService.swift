//
//  MovieService.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

struct MovieService {
    func fetchMovies() async throws -> [MovieDto]{
        let urlString = Endpoints.popularMovies(page: 1).url
        guard let url = URL(string: urlString) else { return []}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
        return decodedResponse.results
    }
}
