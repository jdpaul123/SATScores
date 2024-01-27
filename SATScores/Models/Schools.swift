//
//  SchoolsDTO.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import Foundation

struct School: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case name = "school_name"
        case overview = "overview_paragraph"
    }

    let id, name, overview: String
}
