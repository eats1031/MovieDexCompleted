//
//  MovieDto.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

struct GenreDto: Decodable{
    let id: Int?
    let name: String?
}

struct GenresResponse: Decodable {
    let genres: [GenreDto]?
}
