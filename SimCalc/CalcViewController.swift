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
    
    var calc = Calc.shared
    var calledVC: MainViewController?
    var menuVC: MenuViewController?
    
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
        
        if !self.calc.fetchButtons() {
            _ = self.calc.saveButtons(lines: CalcMode.basicLines)
        }
        
        let stackViewLines:[UIStackView] = [self.line0, self.line1, self.line2, self.line3, self.line4]
        for stackview in stackViewLines {
            for subView in stackview.arrangedSubviews {
                subView.removeFromSuperview()
            }
        }
        
        for (i,line) in self.calc.lines.enumerated() {
            for buttonText in line {
                let button = self.buttonSetting(text: buttonText.getText())
                stackViewLines[i].addArrangedSubview(button)
                
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
    
    func openAlertView(title:String,text:String) {
        let alt = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alt.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alt, animated: true, completion: nil)
    }
    
    
    
    @objc func menuButtonAaction() {
        if self.calledVC?.isSideBarShowing == true{
            self.calledVC?.closeSideBar(animate: true, nil)
        } else {
            self.calledVC?.openSideBar(nil)
        }
    }
    
    @objc func calcButtonTouchUpAction(_ sender:UIButton) {
        sender.backgroundColor = .systemBackground
        if let text = CalcButtonText(rawValue: sender.title(for: .normal)!) {
            switch text {
                case .Delete:
                    if self.textView.text.count > 0 {
                        self.textView.deleteBackward()
                    }
                case .AC: self.textView.text = ""
                case .Equal:
                    if !self.textView.text.isEmpty, !self.textView.text.contains("=") {
                        if let result = self.calc.evaluate(string: self.textView.text) {
                            self.textView.text += " = \(result)"
                            let history = HistoryManager.shared
                            history.insertLog(log: CalcLog(date: Date(), log: self.textView.text ?? ""))
                        } else {
                            self.openAlertView(title: "ERROR", text: "올바르지 않은 계산식입니다.")
                        }
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
