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
    
    /// Creates a WarViewModel object
    var warViewModel: WarViewModel {
        return WarViewModel(participants: transformers)
    }
    
    init() {
        manager = TransformerManager()
    }
    
    /**
     Fetchs a list of transformers from endpoint
     - returns: void
     */
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
    
    /**
     Deletes a transformer using the endpoint
     - parameter indexPath: IndexPath which transformer is selected
     - returns: void
     */
    func delete(at indexPath: IndexPath) {
        manager.delete(transformer: transformers[indexPath.row]) { [weak self] (success, error) in
            if let err = error {
                self?.delegate?.didFail(msg: err.localizedDescription)
                return
            }
           
            self?.transformers.remove(at: indexPath.row)
            self?.delegate?.didLoadData()
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
    
    func createViewModel(at indexPath: IndexPath? = nil) -> CreateTransformerViewModel {
        if let row = indexPath?.row {
            return CreateTransformerViewModel(transformer: transformers[row])
        } else {
            return CreateTransformerViewModel(transformer: nil)
        }
    }
}
