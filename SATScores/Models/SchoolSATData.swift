//
//  SchoolSATData.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import Foundation
struct SchoolSATData: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case name = "school_name"
        case numOfSATTestTakers = "num_of_sat_test_takers"
        case SATCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case SATMathAvgScore = "sat_math_avg_score"
        case SATWritingAvgScore = "sat_writing_avg_score"
    }

    let id, name, numOfSATTestTakers, SATCriticalReadingAvgScore, SATMathAvgScore, SATWritingAvgScore: String
}
