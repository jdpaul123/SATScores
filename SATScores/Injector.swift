//
//  Injector.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import Foundation

final class Injector {
    static let shared = Injector()

    private let networkService: NetworkService
    let dataService: DataService

    init(networkService: NetworkService = DefaultNetworkService(), dataService: DataService? = nil) {
        self.networkService = networkService

        if let dataService {
            self.dataService = dataService
        } else {
            self.dataService = DefaultDataService(networkService: self.networkService)
        }
    }
}
