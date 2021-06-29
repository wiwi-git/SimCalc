//
//  ChangeButtonPositionViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/28.
//

import UIKit
class PositionViewController: UIViewController {
    static let sbId = "sb_id_ChangeButtonPositionViewController"
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var line0PickerView:[UIPickerView]!
    @IBOutlet var line1PickerView:[UIPickerView]!
    @IBOutlet var line2PickerView:[UIPickerView]!
    @IBOutlet var line3PickerView:[UIPickerView]!
    @IBOutlet var line4PickerView:[UIPickerView]!
    
    var calcButtonText = [String]()
    var mainVC:MainViewController?
    lazy var lines:[[UIPickerView]] = [
        self.line0PickerView,
        self.line1PickerView,
        self.line2PickerView,
        self.line3PickerView,
        self.line4PickerView,]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resetButton = UIBarButtonItem(title: "RESET", style: .plain, target: self, action: #selector(self.resetButtonAction))
        
        let saveButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(self.saveButtonAction))

        self.navigationItem.rightBarButtonItems = [resetButton, saveButton]
        self.navigationController?.navigationBar.tintColor = .white
        
        self.textView.layer.cornerRadius = 15
        self.textView.layer.masksToBounds = true
        self.textView.layer.borderWidth = 1
        self.textView.layer.borderColor = UIColor.white.cgColor
        
        self.textView.backgroundColor = .backgroundGreen
        self.textView.isEditable = false
        
        for text in CalcButtonText.allCases {
            self.calcButtonText.append(text.getText())
        }
        
        let textLines = Calc.shared.lines
        for (i,line) in self.lines.enumerated()  {
            let textLine = textLines[i]
            for (k,pv) in line.enumerated() {
                pv.dataSource = self
                pv.delegate = self
                pv.layer.borderWidth = 1
                pv.layer.borderColor = UIColor.white.cgColor
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
    
    @objc func resetButtonAction() {
        let textLines = Calc.shared.lines
        for (i,line) in self.lines.enumerated()  {
            let textLine = textLines[i]
            for (k,pv) in line.enumerated() {
                if let index = self.calcButtonText.firstIndex(where: { (item) -> Bool in
                    if item == textLine[k].rawValue { return true }
                    return false
                }) {
                    pv.selectRow(index, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    @objc func saveButtonAction() {
        var saveFlag = true
        let savedLines = Calc.shared.lines
        
        var linesResult = [[CalcButtonText]]()
        for line in self.lines {
            var lineResult = [CalcButtonText]()
            for pv in line {
                let row = pv.selectedRow(inComponent: 0)
                let text = self.calcButtonText[row]
                if let calcText = CalcButtonText(rawValue: text) {
                    lineResult.append(calcText)
                } else {
                    saveFlag = false
                    print("Error, saveButtonAction - ")
                }
            }
            linesResult.append(lineResult)
        }
        
        guard linesResult.count == Calc.shared.lines.count else {
            saveFlag = false
            return
        }
        
        for (i, line) in linesResult.enumerated() {
            if line.count != savedLines[i].count {
                print("Error, saveButtonAction - ")
                saveFlag = false
                break
            }
        }
        
        if saveFlag, Calc.shared.saveButtons(lines: linesResult) {
            let alert = UIAlertController(title: "SUCCESS", message: "Complete", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "ERROR", message: "FAIL", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension PositionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.calcButtonText.count
    }
    /*
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.calcButtonText[row]
    }*/
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: self.calcButtonText[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}
