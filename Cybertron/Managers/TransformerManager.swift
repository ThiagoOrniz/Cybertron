//
//  TransformerManager.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

typealias TransformerListHandler = ((_ list: [Transformer], _ error: Error?) -> Void)

class TransformerManager {
    
    func fetchAll(_ completion: TransformerListHandler) {

        completion([], nil)
    }
}
