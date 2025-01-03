//
//  MovieDto.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

struct TrailerDto: Decodable{
    let id: String?
    let site: String?
    let type: String?
    let key: String?
}

struct TrailerResponse: Decodable {
    let id: Int
    let results: [TrailerDto]
}

