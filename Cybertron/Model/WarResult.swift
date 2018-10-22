//
//  WarResult.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

/// Save data of a war
struct WarResult {
    
    /// Team which won. case None if tie or both destroyed
    var teamWinner: Team = .none
    
    /// Number of battles
    var numberOfBattles: Int = 0
    
    /// Transformers from winning team
    var winners: [Transformer] = []
    
    /// Transformers from survivor team
    var survivors: [Transformer] = []
    
    /// A basic function to help debugging
    func description() {
        if teamWinner == .none && numberOfBattles > 0 { print("All participants were destroyed"); return }
        
        if teamWinner == .none && numberOfBattles == 0 { print("There was no war. yay!"); return }

        print("\(numberOfBattles) Battle(s)")
        print("Winning team " + teamWinner.teamName)
        print(winners.reduce("") {text, name in "\(text) \(name.nameNormalized)"})
        
        print("Survivors from the losing team:")
        print(survivors.reduce("") {text, name in "\(text) \(name.nameNormalized)"})
    }
}
