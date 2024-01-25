//
//  SchoolsListCell.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import SwiftUI

struct SchoolListCell: View {
    @State private var viewModel: SchoolListCellViewModel

    init(viewModel: SchoolListCellViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            Text(viewModel.name)
        }
    }
}

struct SchoolListCellDataStub {
    static let shared = SchoolListCellDataStub()

    func createViewModel() -> SchoolListCellViewModel {
        SchoolListCellViewModel(name: UUID().uuidString)
    }
}

#Preview {
    SchoolListCell(viewModel: SchoolListCellDataStub.shared.createViewModel())
}
