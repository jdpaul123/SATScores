//
//  SchoolDetailScreenViewModel.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import Foundation

@Observable
class SchoolDetailScreenViewModel {
    struct SATDataPair: Identifiable {
        let id = UUID()
        var label: String
        var value: String
    }

    enum SATData: String, CaseIterable {
        case numOfSATTestTakers
        case SATCriticalMathAvgScore
        case SATMathAvgScore
        case SATWritingAvgScore
    }

    private let id: String
    var name: String
    var SATDataPairs = [SATDataPair]()

    var status: LoadingStates = .loading
    var showBanner = false
    var bannerData = BannerModifier.BannerData()

    init(schoolName: String, schoolID: String) {
        name = schoolName
        id = schoolID
    }

    /// Initializer for previewing and testing
    init(satData: SchoolSATData, showBanner: Bool = false, bannerData: BannerModifier.BannerData = BannerModifier.BannerData()) {
        self.id = satData.id
        self.name = satData.name
        self.SATDataPairs = [
            SATDataPair(label: "Number of SAT Test Takers", value: satData.numOfSATTestTakers),
            SATDataPair(label: "Critical Reading Average Score", value: satData.SATCriticalReadingAvgScore),
            SATDataPair(label: "Math Average Score", value: satData.SATWritingAvgScore),
            SATDataPair(label: "Writing Average Score", value: satData.SATMathAvgScore)
        ]
        self.status = status
        self.showBanner = showBanner
        self.bannerData = bannerData
    }

    func getSchoolSATData() async throws {
        status = .loading
        do {
            let satData = try await Injector.shared.dataService.getSchoolSATData(for: id)
            SATDataPairs = [
                SATDataPair(label: "Number of SAT Test Takers", value: satData.numOfSATTestTakers),
                SATDataPair(label: "Critical Reading Average Score", value: satData.SATCriticalReadingAvgScore),
                SATDataPair(label: "Math Average Score", value: satData.SATWritingAvgScore),
                SATDataPair(label: "Writing Average Score", value: satData.SATMathAvgScore)
            ]
            status = .success
        } catch {
            guard let error = error as? NetworkException else { return }
            bannerData.title = "Error"
            bannerData.detail = error.userMessage
            showBanner = true
            status = .failed
        }
    }
}
