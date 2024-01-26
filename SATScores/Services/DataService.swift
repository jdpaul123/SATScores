//
//  DataService.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import SwiftUI

protocol DataService {
    func getSchools() async throws -> [School]
    func getSchoolSATData(for id: String) async throws -> SchoolSATData
    func resetOffset()
}

final class DefaultDataService: DataService {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getSchools() async throws -> [School] {
        try await networkService.getSchools()
    }

    func getSchoolSATData(for id: String) async throws -> SchoolSATData {
        try await networkService.getSchoolSATData(for: id)
    }

    func resetOffset() {
        networkService.resetOffset()
    }
}
