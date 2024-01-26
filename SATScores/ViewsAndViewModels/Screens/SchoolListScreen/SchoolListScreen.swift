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
            try? await viewModel.fetchMoreSchools()
        }
    }

    var body: some View {
        switch viewModel.status {
        case .loading:
            LoadingView()
                .task {
                    try? await viewModel.fetchSchools()
                }
        case .failed:
            PullToRefreshView()
                .refreshable {
                    try? await viewModel.fetchSchools()
                }
                .banner(data: $viewModel.bannerData, show: $viewModel.showBanner)
        case .success:
            List {
                ForEach(viewModel.searchResults) { school in
                    NavigationLink(destination: SchoolDetailScreen(viewModel: SchoolDetailScreenViewModel(schoolName: school.name, schoolID: school.id))) {
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
        School(id: UUID().uuidString, name: "Example Scgool 1"),
        School(id: UUID().uuidString, name: "Example Scgool 2"),
        School(id: UUID().uuidString, name: "Example Scgool 3"),
        School(id: UUID().uuidString, name: "Example Scgool 4"),
        School(id: UUID().uuidString, name: "Example Scgool 5")
    ]

    func makeViewModel() -> SchoolListScreenViewModel {
        return .init(schools: schools)
    }
}

#Preview {
    SchoolListScreen(viewModel: SchoolListScreenViewModel())
}
