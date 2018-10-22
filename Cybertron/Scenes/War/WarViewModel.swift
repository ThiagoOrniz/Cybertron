//
//  WarViewModel.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class WarViewModel {
    
    let battlefield: BattleFieldManager
    let result: WarResult
    
    init(participants: [Transformer]) {
        battlefield = BattleFieldManager(participants: participants)
        result = battlefield.wageWar()
    }
    
    var numberBattles: String {
        return "\(result.numberOfBattles) Battle(s)"
    }
    
    var winners: String {
        if result.winners.isEmpty {
            return "No one won 😭"
        }
        return result.winners.reduce("") { text, name in "\(text) \(name.name?.capitalized ?? "")" }
    }
    
    /// If there's any URL we return nil and add a place holder image
    var winnerIconUrl: URL? {
        guard let iconUrlString = result.winners.first?.teamIcon else { return nil }
        return URL(string: iconUrlString)
    }
    
    // If there's any URL we return nil and add a place holder image
    var survivorIconUrl: URL? {
        guard let iconUrlString = result.survivors.first?.teamIcon else { return nil }
        return URL(string: iconUrlString)
    }
    
    var survivors: String {
        if result.survivors.isEmpty {
            return "No one survived 😭"
        }
        
        return result.survivors.reduce("") { text, name in "\(text) \(name.name?.capitalized ?? "")" }
    }
}
