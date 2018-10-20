//
//  WarTests.swift
//  CybertronTests
//
//  Created by Thiago Orniz Martin on 2018-10-20.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import XCTest
@testable import Cybertron

class WarTests: XCTestCase {
    
    
    let weakOptimusPrime = Transformer(id: "02", name: "optimus Prime", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team: Team.autobot.rawValue, teamIcon: nil)

    let weakPredaking = Transformer(id: "predaking", name: "predaking", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team: Team.decepticon.rawValue, teamIcon: nil)
    
    let soundwave = Transformer(id: "Soundwave01", name: "Soundwave", strength: 8, intelligence: 9, speed: 2, endurance: 6, rank: 7, courage: 5, firepower: 6, skill: 10, team: Team.decepticon.rawValue, teamIcon: nil)
    
    let bluestreak = Transformer(id: "Bluestreak01", name: "Bluestreak", strength: 6, intelligence: 6, speed: 7, endurance: 9, rank: 5, courage: 2, firepower: 9, skill: 7, team: Team.autobot.rawValue, teamIcon: nil)
    
    let hubcap = Transformer(id: "Hubcap01", name: "Hubcap", strength: 4, intelligence: 4, speed: 4, endurance: 4, rank: 4, courage: 4, firepower: 4, skill: 4, team: Team.autobot.rawValue, teamIcon: nil)
    
    let autobot1 = Transformer(id: "id", name: "autobot1", strength: 4, intelligence: 4, speed: 4, endurance: 4, rank: 7, courage: 4, firepower: 4, skill: 4, team: "A", teamIcon: "")
    
    let decepticon1 = Transformer(id: "id", name: "decepticon1", strength: 5, intelligence: 5, speed: 5, endurance: 5, rank: 8, courage: 5, firepower: 5, skill: 5, team: "D", teamIcon: "")
    
    override func setUp() {
        print(#function)
    }
    
    /**
     Test the battle in the requirements file
     ```
     Input
     Soundwave, D, 8,9,2,6,7,5,6,10
     Bluestreak, A, 6,6,7,9,5,2,9,7
     Hubcap: A, 4,4,4,4,4,4,4,4
     
     The output should be:
     1 battle
     Winning team (Decepticons): Soundwave
     Survivors from the losing team (Autobots): Hubcap
     ```
     - returns: void
     */
    func testBattleInRequirements() {
        // 1 battle
        // Winning team (Decepticons): Soundwave
        // Survivors from the losing team (Autobots): Hubcap
        
        let battleFieldManager = BattleFieldManager(participants: [soundwave, hubcap, bluestreak])
        let result = battleFieldManager.wageWar()
        
        result.description()
        
        XCTAssertTrue(result.teamWinner == .decepticon)
        XCTAssertTrue(result.numberOfBattles == 1)
        XCTAssertTrue(result.survivals.count == 1)
        XCTAssertTrue(result.winners.count == 1)
    }
    
    /**
     Test when optimus prime face predaking
     ```
     It should destroy all.
     ```
     - returns: void
     */
    func testDestroyAll() {
        
        let battleFieldManager = BattleFieldManager(participants: [weakOptimusPrime, weakPredaking, autobot1, decepticon1])
        let result = battleFieldManager.wageWar()
        
        result.description()
        
        XCTAssertTrue(result.teamWinner == .none)
        XCTAssertTrue(result.numberOfBattles == 1)
        XCTAssertTrue(result.survivals.count == 0)
        XCTAssertTrue(result.winners.count == 0)
    }
    
    /**
     Test empty
     - returns: void
     */
    func testEmpty() {
        
        let battleFieldManager = BattleFieldManager(participants: [])
        let result = battleFieldManager.wageWar()
        result.description()
        
        XCTAssertTrue(result.numberOfBattles == 0)
        
    }
    
    /**
     Test participants of just one team
     - returns: void
     */
    func testJustWithOneTeam() {
        
        let battleFieldManager = BattleFieldManager(participants: [bluestreak, autobot1, weakOptimusPrime, hubcap])
        let result = battleFieldManager.wageWar()
        result.description()
        
        XCTAssertTrue(result.numberOfBattles == 0)
    }
    
}
