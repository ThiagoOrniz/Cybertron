//
//  BattleFieldManager.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

enum Fight {
    case win(_ transformer: Transformer)
    case tie
    case destroyAll
}

class BattleFieldManager {
    
    var autobots: [Transformer] = []
    var decepticons: [Transformer] = []
    
    init(participants: [Transformer]) {
        
        // Sort autobots from decepticons
        let transformersTuple = sort(participants: participants)
        
        // Rank both
        autobots = rank(participants: transformersTuple.autobots)
        decepticons = rank(participants: transformersTuple.decepticons)
    }
    
    /**
     Wage a war between the Autobots and the Decepticons
     ```
     For example, given the following input:
     [Soundwave, D, 8,9,2,6,7,5,6,10
      Bluestreak, A, 6,6,7,9,5,2,9,7
      Hubcap: A, 4,4,4,4,4,4,4,4]
     The output should be:
     1 battle
     Winning team (Decepticons): Soundwave
     Survivors from the losing team (Autobots): Hubcap
     ```
     - returns: WarResult model
     */
    func wageWar() -> WarResult {
        var warResult: WarResult = WarResult()
        print("Starting war... 🤖 x 🤖")
        
        var autobotsWinners: [Transformer] = []
        var decepticonsWinners: [Transformer] = []
        
        var autobotsDestroyed: [Transformer] = []
        var decepticonsDestroyed: [Transformer] = []

        while (autobots.count > 0 && decepticons.count > 0) {
            warResult.numberOfBattles += 1
            print("Battle \(warResult.numberOfBattles)")
            
            let fightResult = battle(autobot: autobots[0], decepticon: decepticons[0])
        
            switch fightResult {
            case .win(let transformer):
                switch transformer.transformerTeam {
                case .autobot:
                    autobotsWinners.append(autobots.removeFirst())
                    decepticonsDestroyed.append(decepticons.removeFirst())
                case .decepticon:
                    decepticonsWinners.append(decepticons.removeFirst())
                    autobotsDestroyed.append(autobots.removeFirst())
                case .none: break
                }
            case .tie:
                autobotsDestroyed.append(autobots.removeFirst())
                decepticonsDestroyed.append(decepticons.removeFirst())
            case .destroyAll:
                warResult.teamWinner = .none
                return warResult
            }
        }
 
        // Add winners and losers
        if autobotsWinners.count > decepticonsWinners.count {
            warResult.teamWinner = .autobot
            warResult.winners = autobotsWinners
            warResult.survivals = decepticons
        } else if decepticonsWinners.count > autobotsWinners.count {
            warResult.teamWinner = .decepticon
            warResult.winners = decepticonsWinners
            warResult.survivals = autobots
        }
        return warResult
    }
    
    /**
     Battle method
     ```
     Go for all rules and return a Fight result
     ```
     - parameter autobot: Transformer
     - parameter decepticon: Transformer
     - returns: Fight enum
     */
    func battle(autobot: Transformer, decepticon: Transformer) -> Fight {
        
        print("Autobot side: " + autobot.nameNormalized)
        print("Decepticon side: " + decepticon.nameNormalized)
        print("Fight!")
        
        // Exception rules
        if autobot.isLeader && decepticon.isLeader {
            print("destroyAll")
            return .destroyAll
        }
        
        if autobot.isLeader {
            print("is optimus prime")
            return .win(autobot)
        }
        
        if decepticon.isLeader {
            print("is predaking")
            return .win(decepticon)
        }
        
        // Check if oponent runs away
        if autobot.courage - decepticon.courage >= 4 &&
            autobot.strength - decepticon.strength >= 3 {
            print("decepticon ran away!")
            return .win(autobot)
        }
        
        if decepticon.courage - autobot.courage >= 4 &&
            decepticon.strength - autobot.strength >= 3 {
            print("autobot ran away!")
            return .win(decepticon)
        }
        
        // Check skill
        if autobot.skill - decepticon.skill >= 3 {
            return .win(autobot)
        }
        
        if decepticon.skill - autobot.skill >= 3 {
            return .win(decepticon)
        }
        
        // The winner is the Transformer with the highest overall rating
        print("Autobot: \(autobot.overallRating) x Decepticon: \(decepticon.overallRating)")
        if autobot.overallRating > decepticon.overallRating {
            return .win(autobot)
        } else if decepticon.overallRating > autobot.overallRating {
            return .win(decepticon)
        }
        
        // In the event of a tie, both Transformers are considered destroyed
        return .tie
    }
}

extension BattleFieldManager {
    /**
     Sort for the battle
     
     - parameter participants: [Transformer]
     - returns: Tuple with autobots and decepticons
     */
    private func sort(participants: [Transformer]) -> (autobots: [Transformer], decepticons: [Transformer]) {
        
        let autobots: [Transformer] = participants.filter{ $0.transformerTeam == .autobot }
        let decepticons: [Transformer] = participants.filter{ $0.transformerTeam == .decepticon }
        
        return (autobots, decepticons)
    }
    
    /**
     Rank for the battle
     
     - parameter participants: [Transformer]
     - returns: ranked [Transformer]
     */
    private func rank(participants: [Transformer]) -> [Transformer] {
        return participants.sorted(by: { $0.rank > $1.rank })
    }
}
