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
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.label.cgColor
        self.backgroundColor = .systemBackground
        self.setTitleColor(.white, for: .normal)
        
        self.layer.cornerRadius = frame.width/2
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(hex: "#000052ff")
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = frame.width/2
        self.layer.shadowOpacity = 1.0
        self.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
