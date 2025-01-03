//
//  MovieDto.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

struct Trailer: Decodable {
    let id: String
    let site: String
    let type: String
    let key: String

    init(dto: TrailerDto) {
        self.id = dto.id ?? ""
        self.site = dto.site ?? ""
        self.type = dto.type ?? ""
        self.key = dto.key ?? ""
    }
}
