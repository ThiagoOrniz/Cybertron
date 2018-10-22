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
        
        transformerLabel.textColor = UIColor.CBTColors.title
        overallRatingLabel.textColor = UIColor.CBTColors.subTitle
        rankLabel.textColor = UIColor.CBTColors.title
    }

    func configure(viewModel: TransformerViewModel) {
        transformerLabel.text = viewModel.nameFormatted
        overallRatingLabel.text = viewModel.overallRatingFormatted
        rankLabel.text = viewModel.rankFormatted
        
        if let url = viewModel.url {
            // Af_setImage from AlamofireImage also deals with cache.
            teamImageView.af_setImage(withURL: url)
        } else {
            teamImageView.image = #imageLiteral(resourceName: "placeholder_transformer")
        }
    }
}

extension TransformerCell {
    static var reuseIdentifier: String { return "TransformerCell" }
}
