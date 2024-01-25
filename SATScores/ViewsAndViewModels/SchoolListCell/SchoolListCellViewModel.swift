//
//  SchoolListCellViewModel.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import Foundation

@Observable
class SchoolListCellViewModel {
    var name: String

    init(name: String) {
        self.name = name
    }
}
