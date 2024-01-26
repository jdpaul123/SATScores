//
//  URLSession+SessionProtocol.swift
//  SATScores
//
//  Created by Jonathan Paul on 1/24/24.
//

import Foundation

/// URLSession conforms to Session to allow for mocking the class in unit testing
extension URLSession: Session {}
