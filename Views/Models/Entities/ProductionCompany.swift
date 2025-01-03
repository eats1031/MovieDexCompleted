//
//  MovieDto.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import Foundation

struct ProductionCompany {
    let id: Int
    let logoPath: String
    let name: String
    
    init(dto: ProductionCompanyDto){
        id = dto.id ?? 0
        logoPath = dto.logoPath ?? ""
        name = dto.name ?? ""
    }
}
