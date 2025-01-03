//
//  GenreDto.swift
//  MovieDex
//
//  Created by Luis Becerra on 26/11/24.
//


struct Genre: Decodable{
    let id: Int
    let name: String
    
    init(dto: GenreDto){
        self.id = dto.id ?? 0
        self.name = dto.name ?? ""
    }
}
