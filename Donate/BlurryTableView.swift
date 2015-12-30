//
//  BlurryTableView.swift
//  Donate
//
//  Created by özgür on 28.12.2015.
//  Copyright © 2015 ozgur. All rights reserved.
//

import UIKit

extension UITableView
{
    
    func addBlurryBackground(view:UIView)
    {
        self.backgroundColor = UIColor.clearColor()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        let imview = UIImageView(frame: view.bounds)
        imview.image = UIImage(named: "green.png")
        view.insertSubview(imview, belowSubview: self)
    }
}