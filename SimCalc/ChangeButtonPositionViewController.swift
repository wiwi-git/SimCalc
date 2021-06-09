//
//  ChangeButtonPositionViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/28.
//

import UIKit
class ChangeButtonPositionViewController: UIViewController {
    static let sbId = "sb_id_ChangeButtonPositionViewController"
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var line0PickerView:[UIPickerView]!
    @IBOutlet var line1PickerView:[UIPickerView]!
    @IBOutlet var line2PickerView:[UIPickerView]!
    @IBOutlet var line3PickerView:[UIPickerView]!
    @IBOutlet var line4PickerView:[UIPickerView]!
    
    var calcButtonText = [String]()
    var mainVC:MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.layer.cornerRadius = 15
        self.textView.layer.masksToBounds = true
        self.textView.layer.borderWidth = 1
        self.textView.layer.borderColor = UIColor.black.cgColor
        self.textView.isEditable = false
        for text in CalcButtonText.allCases {
            self.calcButtonText.append(self.getText(button: text) ?? "")
        }
        
        let lines:[[UIPickerView]] = [self.line0PickerView, self.line1PickerView, self.line2PickerView, self.line3PickerView, self.line4PickerView,]
        let textLines = Calc.shared.lines
        for (i,line) in lines.enumerated()  {
            let textLine = textLines[i]
            for (k,pv) in line.enumerated() {
                pv.dataSource = self
                pv.delegate = self
                pv.layer.borderWidth = 1
                pv.layer.cornerRadius = 15
                pv.layer.masksToBounds = true
                if let index = self.calcButtonText.firstIndex(where: { (item) -> Bool in
                    if item == textLine[k].rawValue { return true }
                    return false
                }) {
                    pv.selectRow(index, inComponent: 0, animated: false)
                }
            }
        }
    }
    
    func getText(button:CalcButtonText) -> String? {
        if button != .custom {
            return button.rawValue
        }
        return "미기능"
    }
}
extension ChangeButtonPositionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.calcButtonText.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.calcButtonText[row]
    }
}
