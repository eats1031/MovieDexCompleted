//
//  MovieService.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

struct TrailerService {
    func fetchTrailers(id: Int) async throws -> [TrailerDto]{
        let urlString = Endpoints.trailers(id: id).url
        guard let url = URL(string: urlString) else { return []}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedResponse = try decoder.decode(TrailerResponse.self, from: data)
        return decodedResponse.results
    }
}
