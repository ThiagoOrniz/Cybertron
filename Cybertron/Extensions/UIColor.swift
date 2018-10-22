//
//  UIColor.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // I like to create this struct inside of UIColor, so other devs can easily identify which color is custom in the app. UIColor.CBTColors. ...
    // Normally I give a meaningful name or by its context. Sometimes I repeat the same color but with different names.
    // For example:
    // I have a label placeholder grayish color that it's the same as the navbar color. I create two vars because they have a diferent context, so in the future if the color of the navbar changes I don't need to refactor all the label placeholders.
    
    /// Custom colors of the App
    struct CBTColors {
        
        static var navbarBackground: UIColor {
            return .black
        }
        
        static var navbarText: UIColor {
            return .white
        }
        
        static var background: UIColor {
            return .black
        }
        
        static var backgroundForm: UIColor {
            return UIColor.white.withAlphaComponent(0.1)
        }
        
        static var title: UIColor {
            return .white
        }
        
        static var subTitle: UIColor {
            return UIColor.white.withAlphaComponent(0.5)
        }
    }
}
