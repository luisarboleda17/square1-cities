//
//  TextField+LeftIcon.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

extension UITextField {
    /**
     Set left icon image
     */
    func setLeftIcon(imageName: String, horizontalPadding: Double = 16.0, verticalPadding: Double = 8.0) {
        // Definen icon parameters
        let textFieldHeight = Double(self.layer.bounds.size.height)
        let iconSize = textFieldHeight - verticalPadding * 2
    
        // Container and image
        let containerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + horizontalPadding * 2, height: textFieldHeight))
        let iconView = UIImageView(frame: CGRect(x: horizontalPadding, y: verticalPadding, width: iconSize, height: iconSize))
        iconView.image = UIImage(named: imageName)
        containerView.addSubview(iconView)
        
        self.leftView = containerView
        self.leftViewMode = .always
    }
}

extension UITextField {
    func setSearchStyle() {
        self.layer.cornerRadius = CGFloat(DEFAULT_BORDER_RADIUS)
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.backgroundColor = Colors.backgroundGrey.cgColor
    }
}
