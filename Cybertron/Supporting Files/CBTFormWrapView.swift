//
//  FormWrapView.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import UIKit

class CBTFormWrapView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.CBTColors.backgroundForm
        layer.cornerRadius = Const.Padding.formCorner
    }
}
