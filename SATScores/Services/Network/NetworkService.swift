//
//  NetworkManager.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import Foundation

protocol NetworkService: AnyObject {
    func getSchools() async throws -> [School]
    func getSchoolSATData(for id: String) async throws -> SchoolSATData
    func resetOffset()
}

final class DefaultNetworkService: NetworkService {
    private let baseURLString = "https://data.cityofnewyork.us/resource/"
    private let session: Session

    private let searchLimit = 50
    private var offset = 0

    init(session: Session = URLSession.shared) {
        self.session = session
    }

    func getSchools() async throws -> [School] {
        let endpoint = "\(baseURLString)s3k6-pzi2.json?$limit=\(searchLimit)&$offset=\(offset)"

        let response: [School] = try await fetchAndDecode(from: endpoint)

        offset += searchLimit
        return response
    }

    func resetOffset() {
        offset = 0
    }

    func getSchoolSATData(for id: String) async throws -> SchoolSATData {
        let endpoint = "\(baseURLString)f9bf-2cp4.json?dbn=\(id)"

        let response: [SchoolSATData] = try await fetchAndDecode(from: endpoint)
        guard let schoolSATData = response.first else {
            throw NetworkException.badIndex
        }

        return schoolSATData
    }

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
}
