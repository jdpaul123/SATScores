//
//  NetworkManager.swift
//  Desserts
//
//  Created by Jonathan Paul on 1/8/24.
//

import Foundation

protocol NetworkService: AnyObject {
    func getSchools() async throws -> [School]
    func getSchoolSATData(for id: String) async throws -> SchoolSATData
    func getImageData(from url: URL) async throws -> Data
}

final class DefaultNetworkService: NetworkService {
    private let baseURLString = "https://data.cityofnewyork.us/resource/"
    private let session: Session

    init(session: Session = URLSession.shared) {
        self.session = session
    }

    /// Get all the desserts
    func getSchools() async throws -> [School] {
        let endpoint = "\(baseURLString)s3k6-pzi2.json?$limit=50"

        let response: [School] = try await fetchAndDecode(from: endpoint)

        return response
    }

    func getSchoolSATData(for id: String) async throws -> SchoolSATData {
        let endpoint = "\(baseURLString)f9bf-2cp4.json?dbn=\(id)"

        let response: [SchoolSATData] = try await fetchAndDecode(from: endpoint)
        guard let schoolSATData = response.first else {
            throw NetworkException.badIndex
        }

        return schoolSATData
    }

    // TODO: Add a check if there was a network connection problem
    /// Generic function to decode JSON data
    private func fetchAndDecode<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkException.invalidURL
        }

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(from: url)
        } catch {
            throw NetworkException.unableToComplete
        }

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkException.invalidResponse
        }

        let decodedData: T
        let decoder = JSONDecoder()
        do {
            decodedData = try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkException.invalidData
        }

        return decodedData
    }

    /// Get image data from a URL
    func getImageData(from url: URL) async throws -> Data {
        let imageData: Data
        let response: URLResponse
        do {
            (imageData, response) = try await session.data(from: url)
        } catch {
            throw NetworkException.unableToComplete
        }

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkException.invalidResponse
        }

        return imageData
    }
}
