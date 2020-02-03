//
//  Ext+UIColor.swift
//  TodoApp
//
//  Created by Muis on 02/02/20.
//

import UIKit

extension UIColor {
    static let xRomantic = UIColor.fromHex("#FFD3C3")!
}
/*
https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
*/

extension UIColor {
    fileprivate convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    
    /// Create UIColor from hex string
    ///
    /// - Parameter string: # + 6 (or + alpha) character hex string
    /// - Returns: UIColor object
    static func fromHex(_ string: String) -> UIColor? {
        let hex: String
        if string.count == 7 {
            hex = "\(string)ff".lowercased()
        } else {
            hex = string.lowercased()
        }
        return UIColor(hex: hex)
    }
}

