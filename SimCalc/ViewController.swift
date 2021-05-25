//
//  ViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var saveButton:UIButton!
    @IBOutlet weak var menuButton:UIButton!
    
    @IBOutlet weak var line0:UIStackView!
    @IBOutlet weak var line1:UIStackView!
    @IBOutlet weak var line2:UIStackView!
    @IBOutlet weak var line3:UIStackView!
    @IBOutlet weak var line4:UIStackView!
    
    var calc = Calc()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calc.lines = CalcMode.basicLines
        
        for buttonText in self.calc.lines[0] {
            let text = self.getText(button: buttonText)
            let frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 80))
            let button = CalcButton(frame: frame)
            button.setTitle(text, for: .normal)
            button.addTarget(self, action: #selector(self.buttonTouchUpAction(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonTouchDownAction(_:)), for: .touchDown)
            self.line0.addArrangedSubview(button)
        }
        
        for buttonText in self.calc.lines[1] {
            let text = self.getText(button: buttonText)
            let frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 80))
            let button = CalcButton(frame: frame)
            button.setTitle(text, for: .normal)
            button.addTarget(self, action: #selector(self.buttonTouchUpAction(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonTouchDownAction(_:)), for: .touchDown)
            self.line1.addArrangedSubview(button)
        }
        
        for buttonText in self.calc.lines[2] {
            let text = self.getText(button: buttonText)
            let frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 80))
            let button = CalcButton(frame: frame)
            button.setTitle(text, for: .normal)
            button.addTarget(self, action: #selector(self.buttonTouchUpAction(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonTouchDownAction(_:)), for: .touchDown)
            self.line2.addArrangedSubview(button)
        }
        
        for buttonText in self.calc.lines[3] {
            let text = self.getText(button: buttonText)
            let frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 80))
            let button = CalcButton(frame: frame)
            button.setTitle(text, for: .normal)
            button.addTarget(self, action: #selector(self.buttonTouchUpAction(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonTouchDownAction(_:)), for: .touchDown)
            self.line3.addArrangedSubview(button)
        }
        
        for buttonText in self.calc.lines[4] {
            let text = self.getText(button: buttonText)
            let frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 80))
            let button = CalcButton(frame: frame)
            button.setTitle(text, for: .normal)
            button.addTarget(self, action: #selector(self.buttonTouchUpAction(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonTouchDownAction(_:)), for: .touchDown)
            self.line4.addArrangedSubview(button)
        }
    }
    
    func getText(button:CalcButtonText) -> String? {
        if button != .custom {
            return button.rawValue
        }
        return "미기능"
    }
    
    @objc func buttonTouchUpAction(_ sender:UIButton) {
        sender.backgroundColor = .systemBackground
    }
    
    @objc func buttonTouchDownAction(_ sender:UIButton) {
        sender.backgroundColor = .lightGray
    }
}

