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
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var positionButton:UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var storageButton: UIButton!
    
    let menuTitle:[ButtonTag:String] = [
        .history : "History".localized(),
        .position : "Change Button Layout".localized(),
        .storage : "Storage".localized()
    ]
    
    var delegate: MenuViewControllerDelegate?
    var calldVC: CalcViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundGreen
        self.menuView.backgroundColor = .backgroundGreen
        self.buttonSetting(self.positionButton, tag: .position)
        self.buttonSetting(self.historyButton, tag: .history)
        self.buttonSetting(self.storageButton, tag: .storage)
    }
    
    func buttonSetting(_ button: UIButton, tag:ButtonTag) {
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitle(self.menuTitle[tag], for: .normal)
        button.tag = tag.rawValue
        button.addTarget(self, action: #selector(menuButtonAction(_:)), for: .touchUpInside)
        let lineFrame = CGRect(x: 0, y: button.frame.height - 1, width: button.frame.width, height: 1)
        let line = UIView(frame: lineFrame)
        line.backgroundColor = .white
        button.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            line.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
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
