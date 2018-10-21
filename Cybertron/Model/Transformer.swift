//
//  Transformer.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

struct Transformer: Decodable {
    var id: String?
    var name: String?
    var strength: Int = 0
    var intelligence: Int = 0
    var speed: Int = 0
    var endurance: Int = 0
    var rank: Int = 0
    var courage: Int = 0
    var firepower: Int = 0
    var skill: Int = 0
    var team: String?
    var teamIcon: String?
}

extension Transformer {
    // The “overall rating” of a Transformer is the following formula:
    // (Strength + Intelligence + Speed + Endurance + Firepower).
    var overallRating: Int {
        return strength + intelligence + speed + endurance + firepower
    }
}

extension Transformer {
    var transformerTeam: Team {
        return Team(rawValue: team ?? "") ?? .none
    }
    
    // For comparisons 
    var nameNormalized: String {
        return name?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    var isLeader: Bool {
        switch transformerTeam {
        case .autobot: return nameNormalized == "optimus prime"
        case .decepticon: return nameNormalized == "predaking"
        case .none: return false
        }
    }
}

extension Transformer: Equatable {
    static func == (lhs: Transformer, rhs: Transformer) -> Bool {
        return lhs.id == rhs.id &&
            lhs.nameNormalized == rhs.nameNormalized
    }
}
