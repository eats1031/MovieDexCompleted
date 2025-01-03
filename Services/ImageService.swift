//
//  ImageService.swift
//  MovieDex
//
//  Created by Luis Becerra on 19/11/24.
//

import Foundation
import UIKit

struct ImageService {
    func fetchImage(path: String) async throws -> Data {
        let urlString = Endpoints.remoteImage(path: path).url
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
