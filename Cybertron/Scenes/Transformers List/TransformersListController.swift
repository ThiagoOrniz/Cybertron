//
//  TransformersListController.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import UIKit

class TransformersListController: UIViewController {
    
    private let viewModel: TransformersListViewModel
    
    // MARK: - Initialization
    public init() {
        self.viewModel = TransformersListViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)

    }
}

// MARK: - TransformersListDelegate
extension TransformersListController: TransformersListDelegate {
    func didFail(msg: String) {
        print(msg)
    }
    
    func didLoadData() {
        print(#function)
        print(viewModel.transformers)
        
    }
}
