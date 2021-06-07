//
//  MenuViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/05/27.
//

import UIKit

protocol MenuViewControllerDelegate {
    func openChangeCalc()
}
class MenuViewController: UIViewController {
    static let sbId = "sb_id_ MenuViewController"
    @IBOutlet weak var chageCalcPositionButton:UIButton!
    var delegate:MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        self.chageCalcPositionButton.addTarget(self, action: #selector(self.chageCalcPositionButtionAction), for: .touchUpInside)
    }
    
    @objc func chageCalcPositionButtionAction() {
        self.delegate?.openChangeCalc()
    }
    
}
