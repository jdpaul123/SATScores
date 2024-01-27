//
//  DataService.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import SwiftUI

protocol DataService {
    func getSchoolsSATData() async throws -> [SchoolSATData]
    func getSchoolData(for id: String) async throws -> School
    func resetOffset()
}

final class DefaultDataService: DataService {
    func getSchoolsSATData() async throws -> [SchoolSATData] {
        try await networkService.getSchoolsSATData()
    }
    
    func getSchoolData(for id: String) async throws -> School {
        try await networkService.getSchoolData(for: id)
    }
    
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func resetOffset() {
        networkService.resetOffset()
    }
}
