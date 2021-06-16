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
        self.layer.masksToBounds = false
        
        self.backgroundColor = UIColor.buttonGreen
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
