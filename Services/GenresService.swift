//
//  MovieService.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

struct GenresService {
    func fetchGenres() async throws -> [GenreDto]{
        let urlString = Endpoints.genres.url
        guard let url = URL(string: urlString) else { return []}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse = try decoder.decode(GenresResponse.self, from: data)
        guard let results = decodedResponse.genres else { return [] }
        return results
    }
}
