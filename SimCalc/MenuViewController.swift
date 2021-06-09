//
//  MenuViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/27.
//

import UIKit

protocol MenuViewControllerDelegate {
    func openChangeCalc()
    func openHistory()
}
class MenuViewController: UIViewController {
    static let sbId = "sb_id_ MenuViewController"
    enum ButtonTag: Int {
        case position = 10
        case history
    }
    @IBOutlet weak var positionButton:UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    
    var delegate: MenuViewControllerDelegate?
    var calldVC: CalcViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonSetting(positionButton, tag: .position)
        self.buttonSetting(historyButton, tag: .history)
    }
    
    func buttonSetting(_ button: UIButton, tag:ButtonTag) {
        button.tag = tag.rawValue
        button.addTarget(self, action: #selector(menuButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func menuButtonAction(_ sender: UIButton) {
        if let select = ButtonTag(rawValue: sender.tag) {
            switch select {
                case .position: self.delegate?.openChangeCalc()
                case .history: self.delegate?.openHistory()
            }
        }
    }
    
}
