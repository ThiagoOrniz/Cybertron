//
//  WarResult.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

struct WarResult {
    var teamWinner: Team = .none
    var numberOfBattles: Int = 0
    var winners: [Transformer] = []
    var survivals: [Transformer] = []
    
    func description() {
        if teamWinner == .none && numberOfBattles > 0 { print("All participants were destroyed"); return }
        
        if teamWinner == .none && numberOfBattles == 0 { print("There was no war. yay!"); return }

        print("\(numberOfBattles) Battle(s)")
        print("Winning team " + teamWinner.teamName)
        print(winners.reduce("") {text, name in "\(text) \(name.nameNormalized)"})
        
        print("Survivors from the losing team:")
        print(survivals.reduce("") {text, name in "\(text) \(name.nameNormalized)"})
    }
}
