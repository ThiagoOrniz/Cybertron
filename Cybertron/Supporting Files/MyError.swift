//
//  MyError.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-20.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

enum MyError: Error, LocalizedError {
    case failToken
    case failDeletion
    
    var errorDescription: String? {
        switch self {
        case .failToken:
            return "Couldn't authenticate"
        case .failDeletion:
            return "Couldn't delete transformer"
        }
    }
}
