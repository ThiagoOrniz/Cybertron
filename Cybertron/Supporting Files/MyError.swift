//
//  MyError.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-20.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

/// Custom errors of the app
enum MyError: Error, LocalizedError {
    case failToken
    case failDeletion
    case unknown
    
    /// We can add localized strings here
    var errorDescription: String? {
        switch self {
        case .failToken:
            return "Couldn't authenticate"
        case .failDeletion:
            return "Couldn't delete transformer"
        case .unknown:
            return "Something went wrong"
        }
    }
}
