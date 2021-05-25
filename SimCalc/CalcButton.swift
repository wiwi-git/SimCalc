//
//  CalcButton.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/25.
//

import UIKit

class CalcButton:UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.label.cgColor
        self.backgroundColor = .systemBackground
        self.setTitleColor(.label, for: .normal)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
