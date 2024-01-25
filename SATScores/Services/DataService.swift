//
//  DataService.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/9/24.
//

import SwiftUI

protocol DataService {
    func getSchools() async throws -> [School]
    func getSchoolSATData(for id: String) async throws -> SchoolSATData
    func getImage(from url: URL) async throws -> Image
}

final class DefaultDataService: DataService {
    private let networkService: NetworkService
    private let imageCache: ImageCache

    init(networkService: NetworkService, imageCache: ImageCache) {
        self.networkService = networkService
        self.imageCache = imageCache
    }

    /// Get all the desserts and sort the data
    func getSchools() async throws -> [School] {
        var schools = try await networkService.getSchools()

        // Sort the desserts by name alphabetically
        schools.sort { $0.name < $1.name }

        return schools
    }

    func getSchoolSATData(for id: String) async throws -> SchoolSATData {
        try await networkService.getSchoolSATData(for: id)
    }


    ///  Get the image data from the url
    func getImage(from url: URL) async throws -> Image {
        try await imageCache.getImage(from: url)
    }
}
