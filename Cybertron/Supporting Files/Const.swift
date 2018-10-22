//
//  Const.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-20.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import UIKit

struct Const {
    
    struct UserDefaultKeys {
        static let tokenKey = "tokenKey"
    }
    
    struct Padding {
        static let tableView: CGFloat = 0
        static let tableViewBottom: CGFloat = 75
        static let mainButtonCorner: CGFloat = 16
        static let formCorner: CGFloat = 16
    }
    
    struct WarValues {
        static let kMinCourage = 4
        static let kMinStrength = 3
        static let kMinSkill = 3
    }
    
    struct Fonts {
        static let title = UIFont.boldSystemFont(ofSize: 16)
    }
}
