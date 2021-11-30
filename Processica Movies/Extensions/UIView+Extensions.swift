//
//  UIView+Extensions.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 30.11.21.
//

import UIKit

extension UIView  {
    @IBInspectable
       var cornerRadius: CGFloat {
           get {
               return layer.cornerRadius
           }
           set {
               layer.cornerRadius = newValue
               layer.masksToBounds = newValue > 0
           }
       }
}
