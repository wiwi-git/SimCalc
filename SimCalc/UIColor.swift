//
//  UIColor.swift
//  SimCalc
//
//  Created by 위대연 on 2021/06/15.
//
import UIKit

extension UIColor {
    static var buttonGreen:UIColor {
        UIColor(hex: "#58a982ff")!
    }
    static var selectedButtonGreen:UIColor {
        UIColor(hex: "#015401ff")!
    }
    static var backgroundGreen:UIColor {
        UIColor(hex: "#58c782ff")!
    }
    
    public convenience init?(hex: String) {
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
}