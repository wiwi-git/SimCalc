//
//  ChangeButtonPositionViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/28.
//

import UIKit
class ChangeButtonPositionViewController: UIViewController {
    static let sbId = "sb_id_ChangeButtonPositionViewController"
    @IBOutlet var line0PickerView:[UIPickerView]!
    @IBOutlet var line1PickerView:[UIPickerView]!
    @IBOutlet var line2PickerView:[UIPickerView]!
    @IBOutlet var line3PickerView:[UIPickerView]!
    @IBOutlet var line4PickerView:[UIPickerView]!
    
    var calcButtonText = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for text in CalcButtonText.allCases {
            self.calcButtonText.append(self.getText(button: text) ?? "")
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
