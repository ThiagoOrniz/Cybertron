//
//  TransformersListViewModel.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation

protocol TransformersListDelegate: class {
    func didFail(msg: String)
    func didLoadData()
}

class TransformersListViewModel {
    
    weak var delegate: TransformersListDelegate?
    
    var manager: TransformerManager
    var transformers: [Transformer] = []
    
    var isEmpty: Bool {
        return transformers.isEmpty
    }
    
    var createViewModel: CreateTransformerViewModel {
        return CreateTransformerViewModel(transformer: nil)
    }
    
    init() {
        manager = TransformerManager()
    }
    
    func fetchData() {
        
        manager.fetchAll { [weak self] (transformers, error) in
            if let err = error {
                self?.delegate?.didFail(msg: err.localizedDescription)
                return
            }
            self?.transformers = transformers
            self?.delegate?.didLoadData()
        }
    }
    
    func createData() {
        let autobot1 = Transformer(id: nil, name: "First Autobot!", strength: 4, intelligence: 4, speed: 4, endurance: 4, rank: 7, courage: 4, firepower: 4, skill: 4, team: "A", teamIcon: nil)

 
        manager.create(transformer: autobot1) { [weak self] (transformer, error) in
            if let err = error {
                self?.delegate?.didFail(msg: err.localizedDescription)
                return
            }
            self?.fetchData()
        }
    }
    
    func updateData() {
        let autobot1 = Transformer(id: "-LPID85zded7InqzFpDm", name: "Updated name", strength: 4, intelligence: 4, speed: 4, endurance: 4, rank: 7, courage: 4, firepower: 4, skill: 4, team: "A", teamIcon: nil)
        
        manager.update(transformer: autobot1) { [weak self] (transformer, error) in
            if let err = error {
                self?.delegate?.didFail(msg: err.localizedDescription)
                return
            }
            self?.fetchData()
        }
    }
    
    func deleteData() {
        let autobot1 = Transformer(id: "-LPID85zded7InqzFpDm", name: "Updated name", strength: 4, intelligence: 4, speed: 4, endurance: 4, rank: 7, courage: 4, firepower: 4, skill: 4, team: "A", teamIcon: nil)
        
        manager.delete(transformer: autobot1) { [weak self] (success, error) in
            if let err = error {
                self?.delegate?.didFail(msg: err.localizedDescription)
                return
            }
            self?.fetchData()
        }
    }
}

// MARK: - Table view methods related
extension TransformersListViewModel {
    func numberOfRows() -> Int {
        return transformers.count
    }
    
    func transformerViewModel(at indexPath: IndexPath) -> TransformerViewModel {
        return TransformerViewModel(transformer: transformers[indexPath.row])
    }
}
