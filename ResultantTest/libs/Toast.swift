//
//  Toast.swift
//  ResultantTest
//
//  Created by Dmytro Gayenko on 18.07.2018.
//  Copyright © 2018 Dmytro Gayenko. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    public func showToast(message:String, duration:Int = 2000, bgcolor: UIColor = UIColor.darkGray) {
        
        let toastLabel = UIPaddingLabel();
        toastLabel.padding = 10;
        toastLabel.translatesAutoresizingMaskIntoConstraints = false;
        toastLabel.backgroundColor = bgcolor;
        toastLabel.textColor = UIColor.white;
        toastLabel.textAlignment = .center;
        toastLabel.text = message;
        toastLabel.numberOfLines = 0;
        toastLabel.alpha = 0.9;
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true;
        
        self.addSubview(toastLabel);
        
        self.addConstraint(NSLayoutConstraint(item:toastLabel, attribute:.left, relatedBy:.greaterThanOrEqual, toItem:self, attribute:.left, multiplier:1, constant:20));
        self.addConstraint(NSLayoutConstraint(item:toastLabel, attribute:.right, relatedBy:.lessThanOrEqual, toItem:self, attribute:.right, multiplier:1, constant:-20));
        self.addConstraint(NSLayoutConstraint(item:toastLabel, attribute:.bottom, relatedBy:.equal, toItem:self, attribute:.bottom, multiplier:1, constant:-20));
        self.addConstraint(NSLayoutConstraint(item:toastLabel, attribute:.centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1, constant:0));
        
        UIView.animate(withDuration:0.5, delay:Double(duration) / 1000.0, options:[], animations: {
            
            toastLabel.alpha = 0.0;
            
        }) { (Bool) in
            
            toastLabel.removeFromSuperview();
        }
    }
}
