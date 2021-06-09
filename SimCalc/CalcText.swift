//
//  CalcText.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/25.
//

import Foundation

enum CalcButtonText:String,CaseIterable,Codable {
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
    static let shared = Calc()
    static let saveKey = "key_calc_lines"
    private init() {
        
    }
    var lines:[[CalcButtonText]] = []

    func evaluate(string:String) -> Double? {
        var result:Double? = nil
        
        do {
            try TryCatch.try({
                let expr = NSExpression(format: string)
                result = expr.expressionValue(with: nil, context: nil) as? Double
            })
        } catch {
            print(error)
            return nil
        }
        return result
    }
    
    func saveButtons(lines: [[CalcButtonText]]) {
        print("saveButtons")

        UserDefaults.standard.setValue(lines, forKey: Calc.saveKey)
        UserDefaults.standard.synchronize()
        self.lines = lines
    }
    
    func fetchButtons() -> Bool {
        print("fetchButtons")
        if let array = UserDefaults.standard.array(forKey: Calc.saveKey) {
            if let buttons = array as? [[CalcButtonText]] {
                self.lines = buttons
                return true
            }
        }
        return false
    }
}
