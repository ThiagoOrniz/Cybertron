//
//  UIViewController.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// A simple Ok message to show errors to users
    public func showOKMessage(title: String, content: String) {
        let controller = UIAlertController(title: title,
                                           message: content,
                                           preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        controller.addAction(action)
        present(controller, animated: true)
    }
}
