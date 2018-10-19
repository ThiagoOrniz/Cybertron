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
    
    var transformers: [Transformer] = []
    
    func fetchData() {
        TransformerManager().fetchAll { [weak self] (transformers, error) in
            if let err = error {
                self?.delegate?.didFail(msg: err.localizedDescription)
                return
            }
            self?.transformers = transformers
            self?.delegate?.didLoadData()
        }
    }
    
}
