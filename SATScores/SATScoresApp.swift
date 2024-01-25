//
//  SATScoresApp.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import SwiftUI

@main
struct SATScoresApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SchoolListScreen(viewModel: SchoolListScreenViewModel())
            }
        }
    }
}
