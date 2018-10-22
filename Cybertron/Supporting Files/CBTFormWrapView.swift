//
//  FormWrapView.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import UIKit

/// A simple wrap that deals with forms. In a future app it could have the textfield associated and be an official Form.
class CBTFormWrapView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.CBTColors.backgroundForm
        layer.cornerRadius = Const.Padding.formCorner
    }
}
