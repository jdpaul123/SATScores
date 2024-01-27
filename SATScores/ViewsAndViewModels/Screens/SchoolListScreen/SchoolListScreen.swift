//
//  ContentView.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import SwiftUI

struct SchoolListScreen: View {
    @State private var viewModel: SchoolListScreenViewModel

    init(viewModel: SchoolListScreenViewModel) {
        self.viewModel = viewModel
    }

    var paginationView: some View {
        ZStack(alignment: .center) {
            switch viewModel.paginationState {
            case .loading:
                ProgressView()
            case .idle:
                EmptyView()
            }
        }
        .frame(height: 50)
        .task {
            try? await viewModel.fetchMoreSchoolsSATData()
        }
    }

    var body: some View {
        switch viewModel.status {
        case .loading:
            LoadingView()
                .task {
                    try? await viewModel.fetchSchoolsSATData()
                }
        case .failed:
            PullToRefreshView()
                .refreshable {
                    try? await viewModel.fetchSchoolsSATData()
                }
                .banner(data: $viewModel.bannerData, show: $viewModel.showBanner)
        case .success:
            List {
                ForEach(viewModel.searchResults) { school in
                    NavigationLink(destination: SchoolDetailScreen(viewModel: SchoolDetailScreenViewModel(satData: school))) {
                        SchoolListCell(viewModel: SchoolListCellViewModel(name: school.name))
                    }
                    .listRowSeparator(.hidden)
                }
                paginationView
            }
            .navigationTitle("Schools")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

struct SchoolListScreenDataStub {
    static let shared = SchoolListScreenDataStub()

    private let schools = [
        SchoolSATData(id: "01M292", name: "HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES", numOfSATTestTakers: "29", SATCriticalReadingAvgScore: "355", SATMathAvgScore: "404", SATWritingAvgScore: "363"),
        SchoolSATData(id: "01M448", name: "UNIVERSITY NEIGHBORHOOD HIGH SCHOOL", numOfSATTestTakers: "91", SATCriticalReadingAvgScore: "383", SATMathAvgScore: "423", SATWritingAvgScore: "366"),
        SchoolSATData(id: "01M450", name: "EAST SIDE COMMUNITY SCHOOL", numOfSATTestTakers: "70", SATCriticalReadingAvgScore: "377", SATMathAvgScore: "402", SATWritingAvgScore: "370"),
        SchoolSATData(id: "01M458", name: "FORSYTH SATELLITE ACADEMY", numOfSATTestTakers: "7", SATCriticalReadingAvgScore: "414", SATMathAvgScore: "401", SATWritingAvgScore: "359"),
        SchoolSATData(id: "01M509", name: "MARTA VALLE HIGH SCHOOL", numOfSATTestTakers: "44", SATCriticalReadingAvgScore: "390", SATMathAvgScore: "433", SATWritingAvgScore: "384")
    ]


    func makeViewModel() -> SchoolListScreenViewModel {
        return .init(schools: schools)
    }
}

#Preview {
    SchoolListScreen(viewModel: SchoolListScreenViewModel())
}
