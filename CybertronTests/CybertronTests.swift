//
//  CybertronTests.swift
//  CybertronTests
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import XCTest
@testable import Cybertron

class CybertronTests: XCTestCase {

    var transformer: Transformer!
    
    override func setUp() {
        transformer = Transformer(id: "02", name: "  opTiMus PrIme  ", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team: Team.autobot.rawValue, teamIcon: "https://tfwiki.net/mediawiki/images2/archive/f/fe/20110410191732%21Symbol_autobot_reg.png")
    }
    
    /**
     Test transformer model
     - returns: void
     */
    func testTransformerModel() {
        // Overall Rating
        XCTAssert(transformer.overallRating == 5)
        
        // Normalized name
        XCTAssert(transformer.nameNormalized == "optimus prime")
        
        // Leader
        XCTAssert(transformer.isLeader)
        
        // Team enum
        XCTAssert(transformer.transformerTeam == .autobot)

        transformer.name = "PredaKing "
        transformer.intelligence = 5
        transformer.team = "D"
        
        // Overall Rating
        XCTAssert(transformer.overallRating == 9)

        // Normalized name
        XCTAssert(transformer.nameNormalized == "predaking")
        
        // Leader
        XCTAssert(transformer.isLeader)
        
        // Team enum
        XCTAssert(transformer.transformerTeam == .decepticon)
    }
    
    /**
     Test transformerViewModel
     - returns: void
     */
    func testTransformerViewModel() {
        let viewModel = TransformerViewModel(transformer: transformer)
        
        XCTAssert(viewModel.nameFormatted == "Optimus Prime")
        XCTAssert(viewModel.rankFormatted == "1")
        XCTAssertNotNil(viewModel.url)
    }
}
