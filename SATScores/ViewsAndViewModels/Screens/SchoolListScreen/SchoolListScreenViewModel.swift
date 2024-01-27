//
//  SchoolsListScreenViewModel.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import Foundation

@Observable
class SchoolListScreenViewModel {
    enum PaginationState {
        case idle, loading
    }
    var paginationState: PaginationState = .idle

    var status: LoadingStates = .loading
    var schools: [SchoolSATData]

    var searchText = ""
    var searchResults: [SchoolSATData] {
        if searchText.isEmpty {
            return schools
        } else {
            return schools.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var bannerData = BannerModifier.BannerData()
    var showBanner = false

    init(schools: [SchoolSATData] = []) {
        self.schools = schools
    }

    func fetchSchoolsSATData() async throws {
        status = .loading
        do {
            schools = try await Injector.shared.dataService.getSchoolsSATData()
            status = .success
        } catch {
            guard let error = error as? NetworkException else { return }
            bannerData.title = "Error"
            bannerData.detail = error.userMessage
            showBanner = true
            status = .failed
        }
    }

    func fetchMoreSchoolsSATData() async throws {
        paginationState = .loading
        do {
            let moreSchools = try await Injector.shared.dataService.getSchoolsSATData()
            schools.append(contentsOf: moreSchools)
            paginationState = .idle
        } catch {
            guard let error = error as? NetworkException else { return }
            bannerData.title = "Error"
            bannerData.detail = error.userMessage
            showBanner = true
            paginationState = .idle
        }
    }

    deinit {
        Injector.shared.dataService.resetOffset()
    }
}
