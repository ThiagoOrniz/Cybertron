//
//  TransformerViewModel.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

class TransformerViewModel {
    
    var transformer: Transformer
    
    var nameFormatted: String {
        return transformer.nameNormalized.capitalized
    }
    
    var rankFormatted: String {
        return String(transformer.rank)
    }
    
    var overallRatingFormatted: String {
        return "Overall Rating: \(transformer.overallRating)"
    }
    
    init(transformer: Transformer) {
        self.transformer = transformer
    }
    
    func loadImage(_ completion: ImageHandler) {
        
    }
    
}
