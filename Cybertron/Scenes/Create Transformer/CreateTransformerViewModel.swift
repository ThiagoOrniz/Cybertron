//
//  CreateTransformerViewModel.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

protocol CreateTransformerDelegate: class {
    func didUpdateModel()
    func didMissToUpdate(item: CreateTransformerNumberItems)
    func didFail(msg: String)
    func didSuccess(msg: String)
}

enum CreateTransformerViewModelType {
    case new, edit
}

enum CreateTransformerNumberItems {
    case none, name, team, strength, intelligence, speed, endurance, rank, courage, firepower, skill
}

class CreateTransformerViewModel {
    weak var delegate: CreateTransformerDelegate?
    
    private var transformer: Transformer?
    var type: CreateTransformerViewModelType = .new
    
    var title: String {
        switch type {
        case .edit: return "Edit"
        case .new: return "Create"
        }
    }
    
    var name: String = ""
    var strength: Int = 0
    var intelligence: Int = 0
    var speed: Int = 0
    var endurance: Int = 0
    var rank: Int = 0
    var courage: Int = 0
    var firepower: Int = 0
    var skill: Int = 0
    var team: Team = .none

    var itemBeingUpdated: CreateTransformerNumberItems = .none

    init(transformer: Transformer? = nil) {
        if let transformer = transformer {
            self.transformer = transformer
            name = transformer.name ?? ""
            strength = transformer.strength
            intelligence = transformer.intelligence
            speed = transformer.speed
            endurance = transformer.endurance
            rank = transformer.rank
            courage = transformer.courage
            firepower = transformer.firepower
            skill = transformer.skill
            team = transformer.transformerTeam
            
            type = .edit
        } else {
            type = .new
        }
    }
    
    func selectedTeam(at row: Int) {
        if row == 0 {
            team = .autobot
        } else {
            team = .decepticon
        }
        delegate?.didUpdateModel()
    }
    
    func selected(newValue: Int) {

        switch itemBeingUpdated {
        case .strength: strength = newValue
        case .intelligence: intelligence = newValue
        case .speed: speed = newValue
        case .endurance: endurance = newValue
        case .rank: rank = newValue
        case .courage: courage = newValue
        case .firepower: firepower = newValue
        case .skill: skill = newValue
        case .none, .name, .team: break
        }
        
        itemBeingUpdated = .none
        
        delegate?.didUpdateModel()
    }
    
    func save() {
        if !validate() { return }
        prepareSave()
        
        guard let transformer = transformer else {
            delegate?.didFail(msg: MyError.unknown.localizedDescription)
            return
        }
        
        switch type {
        case .edit:
            TransformerManager().update(transformer: transformer) { [weak self] (transformer, error) in
                if let err = error {
                    self?.delegate?.didFail(msg: err.localizedDescription)
                } else {
                    self?.delegate?.didSuccess(msg: "Transformer updated!")
                }
            }
        case .new:
            TransformerManager().create(transformer: transformer) { [weak self] (transformer, error) in
                if let err = error {
                    self?.delegate?.didFail(msg: err.localizedDescription)
                } else {
                    self?.delegate?.didSuccess(msg: "Transformer created!")
                }
            }
        }
    }

    private func validate() -> Bool {
        
        if name.isEmpty { delegate?.didMissToUpdate(item: .name); return false }
        if strength == 0 { delegate?.didMissToUpdate(item: .strength); return false }
        if intelligence == 0 {delegate?.didMissToUpdate(item: .intelligence); return false }
        if speed == 0 { delegate?.didMissToUpdate(item: .speed); return false }
        if endurance == 0 { delegate?.didMissToUpdate(item: .endurance); return false }
        if rank == 0 { delegate?.didMissToUpdate(item: .rank); return false }
        if courage == 0 { delegate?.didMissToUpdate(item: .courage); return false }
        if firepower == 0 { delegate?.didMissToUpdate(item: .firepower); return false }
        if skill == 0 { delegate?.didMissToUpdate(item: .skill); return false }
        if team == .none { delegate?.didMissToUpdate(item: .team); return false }
        
        return true // yay
    }
    
    private func prepareSave() {
        switch type {
        case .edit:
            transformer?.name = name
            transformer?.strength = strength
            transformer?.intelligence = intelligence
            transformer?.speed = speed
            transformer?.endurance = endurance
            transformer?.rank = rank
            transformer?.courage = courage
            transformer?.firepower = firepower
            transformer?.skill = skill
            transformer?.team = team.rawValue
        case .new:
            transformer = Transformer(id: nil, name: name, strength: strength, intelligence: intelligence, speed: speed, endurance: endurance, rank: rank, courage: courage, firepower: firepower, skill: skill, team: team.rawValue, teamIcon: nil)
        }
    }
}

extension CreateTransformerViewModel {
    static let kMaxSpec: Int = 10
}
