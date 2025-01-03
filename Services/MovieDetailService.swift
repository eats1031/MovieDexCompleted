//
//  MovieService.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

struct MovieDetailService {
    func fetchMovieDetail(id: Int) async throws -> MovieDetailDto?{
        let urlString = Endpoints.movieDetails(id: id).url
        guard let url = URL(string: urlString) else { return nil}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse = try decoder.decode(MovieDetailDto.self, from: data)
        return decodedResponse
    }
}
