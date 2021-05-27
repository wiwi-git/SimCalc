//
//  CalcText.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/25.
//

import Foundation
enum CalcButtonText:String {
    case Parenthesis0 = "("
    case Parenthesis1 = ")"
    case Persent = "%"
    case AC = "AC"
    case Division = "/"
    case Multiplication = "*"
    case Plus = "+"
    case Minus = "-"
    case Equal = "="
    case num0 = "0", num1 = "1", num2 = "2", num3 = "3", num4 = "4", num5 = "5", num6 = "6", num7 = "7", num8 = "8", num9 = "9"
    case Dot = "."
    case Delete = "⌫"
    case custom = "custom"
}

struct CalcMode {
   static let basicLines:[[CalcButtonText]] = [
        [.Parenthesis0, .Parenthesis1, .AC , .Delete],
        [.num7,.num8,.num9,.Division],
        [.num4,.num5,.num6,.Multiplication],
        [.num1,.num2,.num3,.Minus],
        [.num0,.Dot,.Equal,.Plus]
    ]
}

class Calc {
    var lines:[[CalcButtonText]] = []
    
}
