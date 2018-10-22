//
//  TransformerCoverCell.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class TransformerCoverCell: UITableViewCell {

    @IBOutlet weak var transformerNameLabel: UILabel!
    @IBOutlet weak var teamIconImageView: CBTRoundImageView!
    
    func configure(with url: URL?, name: String) {
        transformerNameLabel.text = name

        if let url = url {
            teamIconImageView.af_setImage(withURL: url)
        } else {
            teamIconImageView.image = #imageLiteral(resourceName: "placeholder_transformer")
        }
    }
}

extension TransformerCoverCell {
    static let reuseIdentifier: String = "TransformerCoverCell"
}
