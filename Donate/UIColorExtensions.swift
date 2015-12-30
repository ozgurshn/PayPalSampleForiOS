//
//  UIColorExtensions.swift
//
//  Created by özgür on 23.12.2015.
//

import UIKit

extension UIColor {
    convenience init(r: Int, g:Int , b:Int) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1.0)
    }

    class func buttonNormalGreen()->UIColor {
        return UIColor(r: 23, g: 147, b: 38)
    }
    
    class func buttonHighlightedGreen()->UIColor {
        return UIColor(r: 65, g: 147, b: 65)
    }
    
    
}