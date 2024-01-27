//
//  SchoolDetailScreen.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import SwiftUI

struct SchoolDetailScreen: View {
    @State private var viewModel: SchoolDetailScreenViewModel

    init(viewModel: SchoolDetailScreenViewModel) {
        self.viewModel = viewModel
    }

    let verticalPadding: CGFloat = 4
    let horizontalPadding: CGFloat = 5

    var body: some View {
        List {
            Section {
                ForEach(viewModel.SATDataPairs) { satData in
                    HStack {
                        Text(satData.label)
                        Spacer()
                        Text(satData.value)
                    }
                }
                .padding(.init(top: verticalPadding, leading: horizontalPadding, bottom: verticalPadding, trailing: horizontalPadding))
                .listRowSeparator(.hidden)
            } header: {
                Text("SAT Score Information")
                    .font(.headline)
            }
            if viewModel.hasOverview {
                Section {
                    Text(viewModel.overviewText)
                        .padding(.init(top: verticalPadding, leading: horizontalPadding, bottom: verticalPadding, trailing: horizontalPadding))
                } header: {
                    Text("School Overview")
                        .font(.headline)
                }
            }
        }
        .task {
            try? await viewModel.getSchoolData()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.name)
    }
}
