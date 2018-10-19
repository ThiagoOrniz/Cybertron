//
//  Team.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

enum Team: String {
    case autobot = "A"
    case decepticon = "D"
    //Each Transformer must either be an Autobot or a Decepticon, but we add a none case because this data is coming from the server side and we never know how consistent it is. It is also to avoid force unwrap
    case none = ""
    
    var teamName: String {
        switch self {
        case .autobot: return "Autobots"
        case .decepticon: return "Decepticons"
        case .none: return "Neutral"
        }
    }
}
