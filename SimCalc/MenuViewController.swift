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
    func openStorage()
}
class MenuViewController: UIViewController {
    static let sbId = "sb_id_menu"
    enum ButtonTag: Int {
        case position = 10
        case history
        case storage
    }
    @IBOutlet weak var positionButton:UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var storageButton: UIButton!
    
    var delegate: MenuViewControllerDelegate?
    var calldVC: CalcViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundGreen
        self.buttonSetting(self.positionButton, tag: .position)
        self.buttonSetting(self.historyButton, tag: .history)
        self.buttonSetting(self.storageButton, tag: .storage)
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
                case .storage: self.delegate?.openStorage()
            }
        }
    }
    
}
