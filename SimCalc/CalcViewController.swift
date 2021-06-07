//
//  ViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/25.
//

import UIKit

class CalcViewController: UIViewController {
    @IBOutlet weak var textView:UITextView!
    
    @IBOutlet weak var line0:UIStackView!
    @IBOutlet weak var line1:UIStackView!
    @IBOutlet weak var line2:UIStackView!
    @IBOutlet weak var line3:UIStackView!
    @IBOutlet weak var line4:UIStackView!
    
    var calc = Calc()
    var calledVC: MainViewController?
    
    var menuVC: UIViewController?
    var contentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: .plain, target: self, action: #selector(self.menuButtonAaction))
        self.navigationItem.rightBarButtonItem = menuButton
        
        
        self.textView.delegate = self
        self.textView.inputView = UIView.init()
        self.textView.layer.cornerRadius = 15
        self.textView.layer.masksToBounds = true
        self.textView.layer.borderWidth = 1
        self.textView.layer.borderColor = UIColor.label.cgColor
        self.textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.calc.lines = CalcMode.basicLines
        for v in self.line0.arrangedSubviews {
            v.removeFromSuperview()
        }
        for v in self.line1.arrangedSubviews {
            v.removeFromSuperview()
        }
        for v in self.line2.arrangedSubviews {
            v.removeFromSuperview()
        }
        for v in self.line3.arrangedSubviews {
            v.removeFromSuperview()
        }
        
        for buttonText in self.calc.lines[0] {
            if let text = self.getText(button: buttonText) {
                let button = self.buttonSetting(text: text)
                self.line0.addArrangedSubview(button)
            }
        }
        
        for buttonText in self.calc.lines[1] {
            if let text = self.getText(button: buttonText) {
                let button = self.buttonSetting(text: text)
                self.line1.addArrangedSubview(button)
            }
        }
        
        for buttonText in self.calc.lines[2] {
            if let text = self.getText(button: buttonText) {
                let button = self.buttonSetting(text: text)
                self.line2.addArrangedSubview(button)
            }
        }
        
        for buttonText in self.calc.lines[3] {
            if let text = self.getText(button: buttonText) {
                let button = self.buttonSetting(text: text)
                self.line3.addArrangedSubview(button)
            }
        }
        
        for buttonText in self.calc.lines[4] {
            if let text = self.getText(button: buttonText) {
                let button = self.buttonSetting(text: text)
                self.line4.addArrangedSubview(button)
            }
        }
    }
    
    func buttonSetting(text:String) -> CalcButton {
        let frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 80))
        let button = CalcButton(frame: frame)
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: #selector(self.calcButtonTouchUpAction(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(self.calcButtonTouchDownAction(_:)), for: .touchDown)
        return button
    }
    
    func getText(button:CalcButtonText) -> String? {
        if button != .custom {
            return button.rawValue
        }
        return "미기능"
    }
    
    func openAlertView(title:String,text:String) {
        let alt = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alt.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alt, animated: true, completion: nil)
    }
    
    @objc func menuButtonAaction() {
        if self.calledVC?.isSideBarShowing == true{
            self.calledVC?.closeSideBar(nil)
        } else {
            self.calledVC?.openSideBar(nil)
        }
    }
    
    @objc func calcButtonTouchUpAction(_ sender:UIButton) {
        sender.backgroundColor = .systemBackground
        if let text = CalcButtonText(rawValue: sender.title(for: .normal)!) {
            switch text {
                case .Delete: self.textView.text.removeLast()
                case .AC: self.textView.text = ""
                case .Equal:
                    if !self.textView.text.isEmpty, !self.textView.text.contains("=") {
                        if let result = self.calc.evaluate(string: self.textView.text) {
                            self.textView.text += " = \(result)"
                        } else {
                            self.openAlertView(title: "ERROR", text: "올바르지 않은 계산식입니다.")
                        }
                    } else {
                        self.openAlertView(title: "ERROR", text: "올바르지 않은 계산식입니다.")
                    }
                default: self.textView.insertText(sender.title(for: .normal)!)
            }
        }
    }
    
    @objc func calcButtonTouchDownAction(_ sender:UIButton) {
        sender.backgroundColor = .lightGray
    }
}
extension CalcViewController:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView != self.textView
    }
}
