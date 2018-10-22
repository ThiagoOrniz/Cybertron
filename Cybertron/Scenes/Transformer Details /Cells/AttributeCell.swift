//
//  AttributeCell.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class AttributeCell: UITableViewCell {

    @IBOutlet weak var attributeNameLabel: UILabel!
    @IBOutlet weak var attributeValueLabel: UILabel!
    
    func configure(with attribute: String, value: String) {
        attributeNameLabel.text = attribute
        attributeValueLabel.text = value
    }
}

extension AttributeCell {
    static let reuseIdentifier: String = "AttributeCell"
}
