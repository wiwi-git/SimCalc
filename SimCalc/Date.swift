//
//  Date.swift
//  SimCalc
//
//  Created by 위대연 on 2021/06/11.
//

import Foundation
extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current //TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)   
    }
}
