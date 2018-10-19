//
//  Transformer.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

struct Transformer {
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
    
    // Each Transformer must either be an Autobot or a Decepticon.
    let team: String?
    let teamIcon: String?
}

extension Transformer {
    // The “overall rating” of a Transformer is the following formula:
    // (Strength + Intelligence + Speed + Endurance + Firepower).
    var overallRating: Int {
        return strength + intelligence + speed + endurance + firepower
    }
}
