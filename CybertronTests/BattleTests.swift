//
//  BattleTests.swift
//  CybertronTests
//
//  Created by Thiago Orniz Martin on 2018-10-20.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import XCTest
@testable import Cybertron

class BattleTests: XCTestCase {
    
    
    let weakOptimusPrime = Transformer(id: "02", name: "optimus Prime", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team: Team.autobot.rawValue, teamIcon: nil)
    
    let weakPredaking = Transformer(id: "predaking", name: "predaking", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team: Team.decepticon.rawValue, teamIcon: nil)
    
    let autobot1 = Transformer(id: "id", name: "autobot1", strength: 4, intelligence: 4, speed: 4, endurance: 4, rank: 7, courage: 4, firepower: 4, skill: 4, team: "A", teamIcon: "")
    
    let decepticon1 = Transformer(id: "id", name: "decepticon1", strength: 5, intelligence: 5, speed: 5, endurance: 5, rank: 8, courage: 5, firepower: 5, skill: 5, team: "D", teamIcon: "")
    
    var battleFieldManager = BattleFieldManager(participants: [])
    
    override func setUp() {
        print(#function)
        battleFieldManager.autobots = []
        battleFieldManager.decepticons = []
    }
    
    /**
     Test destroy all in the battle
     ```
     It should destroy all.
     ```
     - returns: void
     */
    func testDestroyAllInBattle() {
        
        let fight = battleFieldManager.battle(autobot: weakOptimusPrime, decepticon: weakPredaking)
        
        switch fight {
        case .tie, .win: XCTFail()
        case .destroyAll: break
        }
    }
    
    /**
     Test when it's optimus prime
     ```
     It should return optimus prime
     ```
     - returns: void
     */
    func testOptimusPrime() {
        
        let fight = battleFieldManager.battle(autobot: weakOptimusPrime, decepticon: decepticon1)
        
        switch fight {
        case .win(let value):
            XCTAssertTrue(value.nameNormalized == weakOptimusPrime.nameNormalized)
        case .tie, .destroyAll:
            XCTFail()
        }
    }
    
    /**
     Test when it's predaking
     ```
     It should return predaking
     ```
     - returns: void
     */
    func testPredaking() {
        
        let fight = battleFieldManager.battle(autobot: autobot1, decepticon: weakPredaking)
        
        switch fight {
        case .win(let value):
            XCTAssertTrue(value.nameNormalized == weakPredaking.nameNormalized)
        case .tie, .destroyAll:
            XCTFail()
        }
    }
    
    /**
     Test oponent running away
     ```
     If any fighter is down 4 or more points of courage AND 3 or more points of strength compared to their opponent, the opponent automatically wins the face-off regardless of overall rating (opponent has ran away)
     ```
     - returns: void
     */
    func testOponentRunningAway() {
        
        let transformer1 = Transformer(id: "id", name: "autobot1", strength: 4, intelligence: 4, speed: 4, endurance: 4, rank: 7, courage: 8, firepower: 4, skill: 4, team: "A", teamIcon: "")
        
        let transformer2 = Transformer(id: "id", name: "decepticon1", strength: 1, intelligence: 5, speed: 5, endurance: 5, rank: 8, courage: 4, firepower: 5, skill: 5, team: "D", teamIcon: "")
        
        var result = battleFieldManager.battle(autobot: transformer1, decepticon: transformer2)
        
        switch result {
        case .win(let value):
            XCTAssertTrue(value == transformer1)
        case .destroyAll, .tie:
            XCTFail()
        }
        
        result = battleFieldManager.battle(autobot: transformer2, decepticon: transformer1)
        
        switch result {
        case .win(let value):
            XCTAssertTrue(value == transformer1)
        case .destroyAll, .tie:
            XCTFail()
        }
    }
    
    /**
     Test oponent skill
     ```
     If one of the fighters is 3 or more points of skill above their opponent, they win the fight regardless of overall rating
     ```
     - returns: void
     */
    func testBattleSkill() {
        
        let transformer1 = Transformer(id: "id", name: "autobot1", strength: 4, intelligence: 4, speed: 4, endurance: 4, rank: 7, courage: 4, firepower: 4, skill: 8, team: "A", teamIcon: "")
        
        let transformer2 = Transformer(id: "id", name: "decepticon1", strength: 1, intelligence: 5, speed: 5, endurance: 5, rank: 8, courage: 4, firepower: 5, skill: 5, team: "D", teamIcon: "")
        
        var result = battleFieldManager.battle(autobot: transformer1, decepticon: transformer2)
        
        switch result {
        case .win(let value):
            XCTAssertTrue(value == transformer1)
        case .destroyAll, .tie:
            XCTFail()
        }
        
        result = battleFieldManager.battle(autobot: transformer2, decepticon: transformer1)
        
        switch result {
        case .win(let value):
            XCTAssertTrue(value == transformer1)
        case .destroyAll, .tie:
            XCTFail()
        }
    }
    
    /**
     Test oponent overall rating
     ```
     The winner is the Transformer with the highest overall rating
     (Strength + Intelligence + Speed + Endurance + Firepower).
     ```
     - returns: void
     */
    func testOverallRating() {
        
        let transformer1 = Transformer(id: "id", name: "autobot1", strength: 5, intelligence: 5, speed: 5, endurance: 5, rank: 7, courage: 4, firepower: 5, skill: 5, team: "A", teamIcon: "")
        
        let transformer2 = Transformer(id: "id", name: "decepticon1", strength: 4, intelligence: 5, speed: 5, endurance: 5, rank: 8, courage: 4, firepower: 5, skill: 5, team: "D", teamIcon: "")
        
        var result = battleFieldManager.battle(autobot: transformer1, decepticon: transformer2)
        
        switch result {
        case .win(let value):
            XCTAssertTrue(value == transformer1)
        case .destroyAll, .tie:
            XCTFail()
        }
        
        result = battleFieldManager.battle(autobot: transformer2, decepticon: transformer1)
        
        switch result {
        case .win(let value):
            XCTAssertTrue(value == transformer1)
        case .destroyAll, .tie:
            XCTFail()
        }
    }
    
    /**
     Test a tie
     - returns: void
     */
    func testTie() {
        
        let transformer1 = Transformer(id: "id", name: "autobot1", strength: 5, intelligence: 5, speed: 5, endurance: 5, rank: 7, courage: 4, firepower: 5, skill: 5, team: "A", teamIcon: "")
        
        let transformer2 = Transformer(id: "id", name: "decepticon1", strength: 5, intelligence: 5, speed: 5, endurance: 5, rank: 8, courage: 4, firepower: 5, skill: 5, team: "D", teamIcon: "")
        
        var result = battleFieldManager.battle(autobot: transformer1, decepticon: transformer2)
        
        switch result {
        case .tie:
            XCTAssertTrue(true)
        case .destroyAll, .win:
            XCTFail()
        }
        
        result = battleFieldManager.battle(autobot: transformer2, decepticon: transformer1)
        
        switch result {
        case .tie:
            XCTAssertTrue(true)
        case .destroyAll, .win:
            XCTFail()
        }
    }
}
