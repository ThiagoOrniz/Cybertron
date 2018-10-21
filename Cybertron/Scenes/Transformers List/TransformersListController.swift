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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wageButton: UIButton!
    
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
        tableView.delegate = self
        tableView.dataSource = self
        
        loadLayout()
        loadNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchData()
    }
    
    // MARK: - Layout
    func loadNavBar() {
        navigationItem.title = "Transformers"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionNew))
    }
    
    private func loadLayout() {
        view.backgroundColor = UIColor.CBTColors.background
        
        wageButton.layer.cornerRadius = Const.Padding.mainButtonCorner
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: Const.Padding.tableView,
                                              left: Const.Padding.tableView,
                                              bottom: Const.Padding.tableViewBottom,
                                              right: Const.Padding.tableView)
        
        tableView.register(UINib(nibName: "TransformerCell", bundle: nil), forCellReuseIdentifier: TransformerCell.reuseIdentifier)
    }
    
    private func showEmptyLabel(_ show: Bool) {
        
        if show {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
            label.textColor = UIColor.CBTColors.subTitle
            label.textAlignment = .center
            label.numberOfLines = 0
            label.text = "I think they are on planet Earth right now."
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func actionWar() {
        let warController = WarController(viewModel: viewModel.warViewModel)
        navigationController?.pushViewController(warController, animated: true)
    }
    
    @objc private func actionNew() {
        let createViewController = CreateTransformerController(viewModel: viewModel.createViewModel())
        navigationController?.pushViewController(createViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension TransformersListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransformerCell.reuseIdentifier, for: indexPath) as? TransformerCell else {
            fatalError(#function)
        }
        cell.configure(viewModel: viewModel.transformerViewModel(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
            self?.viewModel.delete(at: indexPath)
        }
        
        let update = UITableViewRowAction(style: .default, title: "Edit") { [weak self] (action, indexPath) in
            guard let viewModel = self?.viewModel.createViewModel(at: indexPath) else { return }
            let createTransformerController = CreateTransformerController(viewModel: viewModel)
            
            self?.navigationController?.pushViewController(createTransformerController,
                                                     animated: true)
        }
        
        update.backgroundColor = UIColor.CBTColors.backgroundForm
        
        return [delete, update]
    }
    
}

// MARK: - TransformersListDelegate
extension TransformersListController: TransformersListDelegate {
    func didFinishWar() {
        
    }
    
    func didFail(msg: String) {
        showOKMessage(title: "Oops!", content: msg)
        showEmptyLabel(true)
    }
    
    func didLoadData() {
        tableView.reloadData()
        showEmptyLabel(viewModel.isEmpty)
    }
}
