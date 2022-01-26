//
//  UIColorExtension.swift
//  Palette
//
//  Created by Cameron Stuart on 7/10/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    convenience init(_ imaggaColor: ImaggaColor){
        let red = CGFloat(imaggaColor.red) / 255
        let green = CGFloat(imaggaColor.green) / 255
        let blue = CGFloat(imaggaColor.blue) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
