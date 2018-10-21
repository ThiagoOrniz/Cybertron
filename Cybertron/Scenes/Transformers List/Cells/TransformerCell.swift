//
//  TransformerCell.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class TransformerCell: UITableViewCell {

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var transformerLabel: UILabel!
    @IBOutlet weak var overallRatingLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        teamImageView.layer.cornerRadius = teamImageView.frame.width / 2
        transformerLabel.textColor = UIColor.CBTColors.title
        overallRatingLabel.textColor = UIColor.CBTColors.subTitle
        rankLabel.textColor = UIColor.CBTColors.title
    }

    func configure(viewModel: TransformerViewModel) {
        transformerLabel.text = viewModel.nameFormatted
        overallRatingLabel.text = viewModel.overallRatingFormatted
        rankLabel.text = viewModel.rankFormatted

        // FIXME: - Add image after
    }
}

extension TransformerCell {
    static var reuseIdentifier: String { return "TransformerCell" }
}
