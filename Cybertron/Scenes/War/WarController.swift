//
//  WarResultController.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class WarController: UIViewController {
    
    @IBOutlet weak var numberBattlesLabel: UILabel!
    @IBOutlet weak var winnerTeamImageView: CBTRoundImageView!
    @IBOutlet weak var winnerTeamLabel: UILabel!
    @IBOutlet weak var survivorTeamImageView: CBTRoundImageView!
    @IBOutlet weak var survivorsLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    let viewModel: WarViewModel
    
    // MARK: - Initialization
    public init(viewModel: WarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNavBar()
        loadLayout()
    }
    
    // MARK: - Layout
    private func loadNavBar() {
        navigationItem.title = "Arena"
    }
    
    private func loadLayout() {
        doneButton.layer.cornerRadius = Const.Padding.mainButtonCorner
        numberBattlesLabel.text = viewModel.numberBattles
        winnerTeamLabel.text = viewModel.winners
        survivorsLabel.text = viewModel.survivors
        
        if let url = viewModel.winnerIconUrl {
            winnerTeamImageView.af_setImage(withURL: url)
        } else {
            winnerTeamImageView.image = #imageLiteral(resourceName: "placeholder_transformer")
        }
        
        if let url = viewModel.survivorIconUrl {
            survivorTeamImageView.af_setImage(withURL: url)
        } else {
            survivorTeamImageView.image = #imageLiteral(resourceName: "placeholder_transformer")
        }
    }
    
    // MARK: - Actions
    @IBAction func actionDone(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
