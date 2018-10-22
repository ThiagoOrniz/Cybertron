//
//  TransformerDetailsController.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import UIKit

class TransformerDetailsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: TransformerViewModel
    
    
    // MARK: - Initialization
    public init(viewModel: TransformerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadNavBar()
        loadLayout()
    }
    
   
    // MARK: - Layout
    private func loadNavBar() {
        navigationItem.title = "Details"
    }
    
    private func loadLayout() {
        view.backgroundColor = UIColor.CBTColors.background
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: TransformerCoverCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TransformerCoverCell.reuseIdentifier)
        tableView.register(UINib(nibName: AttributeCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: AttributeCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension TransformerDetailsController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TransformerCoverCell.reuseIdentifier, for: indexPath) as? TransformerCoverCell else {
                fatalError(#function)
            }
            let item = viewModel.coverCellValues()
            cell.configure(with: item.url, name: item.name)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.reuseIdentifier, for: indexPath) as? AttributeCell else {
                fatalError(#function)
            }
            let item = viewModel.attributeCellValues(for: indexPath)
            cell.configure(with: item.attribute, value: item.value)
            return cell
        default: fatalError(#function)
        }
    }
}
