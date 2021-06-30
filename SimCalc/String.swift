//
//  String.swift
//  SimCalc
//
//  Created by 위대연 on 2021/06/30.
//

import UIKit
extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
