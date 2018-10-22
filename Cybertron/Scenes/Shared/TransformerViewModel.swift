//
//  TransformerViewModel.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

enum TransformerAttributes {
    case cover, rank, overall, strength, intelligence, speed, endurance, courage, firepower, skill
}

class TransformerViewModel {
    
    var transformer: Transformer
    
    var attributesEnumList: [TransformerAttributes]  = [.rank, .overall, .strength, .intelligence, .speed, .endurance, .courage, .firepower, .skill]
    
    var nameFormatted: String {
        return transformer.nameNormalized.capitalized
    }
    
    var rankFormatted: String {
        return String(transformer.rank)
    }
    
    var overallRatingFormatted: String {
        return "Overall Rating: \(transformer.overallRating)"
    }
    
    var url: URL? {
        return URL(string: transformer.teamIcon ?? "")
    }
    
    init(transformer: Transformer) {
        self.transformer = transformer
    }
}

// MARK: - Tableview related methods
extension TransformerViewModel {
    func numberOfRows(for section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return attributesEnumList.count
        default: return 0
        }
    }
    
    func coverCellValues() -> (url: URL?, name: String) {
        return (url, nameFormatted)
    }
    
    func attributeCellValues(for indexPath: IndexPath) -> (attribute: String, value: String) {
        switch attributesEnumList[indexPath.row] {
        case .strength:
            return ("Strength", String(transformer.strength))
        case .cover:
            return ("","")
        case .intelligence:
            return ("Intelligence", String(transformer.intelligence))
        case .speed:
            return ("Speed", String(transformer.speed))
        case .endurance:
            return ("Endurance", String(transformer.endurance))
        case .courage:
            return ("Courage", String(transformer.courage))
        case .firepower:
            return ("Firepower", String(transformer.firepower))
        case .skill:
            return ("Skill", String(transformer.skill))
        case .rank:
            return ("Rank", String(transformer.rank))
        case .overall:
            return ("Overall Rating", String(transformer.overallRating))
        }
    }
}
