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
            return "No one won"
        }
        return result.winners.reduce("") { text, name in "\(text) \(name.name ?? "")" }
    }
    
    var survivors: String {
        if result.survivors.isEmpty {
            return "No one survived"
        }
        
        return result.survivors.reduce("") { text, name in "\(text) \(name.name ?? "")" }
    }
}