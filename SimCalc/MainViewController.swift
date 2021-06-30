//
//  MainViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/06/07.
//

import UIKit
class MainViewController: UIViewController {
    var contentVC: UIViewController?
    var sideVC: UIViewController?

    var isSideBarShowing = false
    
    let SLIDE_TIME: Double = 0.2
    let SIDEBAR_WIDTH: CGFloat = 260
    let MAX_HISTORY: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.view.backgroundColor = .backgroundGreen
        let history = HistoryManager.shared
        if let count = history.count(request: History.fetchRequest()) {
            if count > self.MAX_HISTORY {
                let fetchResult = history.fetch(request: History.fetchRequest())
                let deleteCount = fetchResult.count - self.MAX_HISTORY
                for i in 0 ..< deleteCount {
                    history.delete(object: fetchResult[i])
                }
            }
        } else {
            print("error history")
        }
    }
    
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if shadow {
            self.contentVC?.view.layer.cornerRadius = 5
            self.contentVC?.view.layer.shadowOpacity = 0.5
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
        } else {
            self.contentVC?.view.layer.cornerRadius = 0
            self.contentVC?.view.layer.shadowOffset = CGSize.zero
        }
    }
    
    func setupView() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sb_id_calcnavi") as? UINavigationController {
            self.contentVC = vc
            self.contentVC?.view.layer.masksToBounds = false
            self.addChild(vc)
            
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
            
            let calcVC = vc.viewControllers[0] as? CalcViewController
            calcVC?.calledVC = self
        }
    }
    
    func getSideView(){
        if self.sideVC == nil {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: MenuViewController.sbId) {
                self.sideVC = vc
                (self.sideVC as? MenuViewController)?.delegate = self
                self.sideVC?.view.frame = CGRect(x: self.view.frame.width - self.SIDEBAR_WIDTH, y: 0, width: self.SIDEBAR_WIDTH, height: self.view.frame.height)
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
                self.view.bringSubviewToFront((self.contentVC?.view)!)
            }
        }
    }
    
    func openSideBar(_ complete: ( () -> Void)? ) {
        self.getSideView()
        self.setShadowEffect(shadow: true, offset: -2)
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options) {
            self.contentVC?.view.frame = CGRect(x: -self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        } completion: { (result) in
            if result {
                self.isSideBarShowing = true
                complete?()
            }
        }
    }
    
    func closeSideBar(animate:Bool, _ complete: ( () -> Void )? ) {
        let duration = animate ? self.SLIDE_TIME : 0
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(0), options: options) {
            self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        } completion: { result in
            if result {
                self.sideVC?.view.removeFromSuperview()
                self.sideVC = nil
                self.isSideBarShowing = false
                self.setShadowEffect(shadow: false, offset: 0)
                complete?()
            }
        }
    }
    
    func showToast(message:String, time:Double) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        let label = UILabel(frame: CGRect(x: 8, y: 8, width: view.frame.width - 16, height: view.frame.height - 16))
        label.textColor = .white
        label.text = message
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.8)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        self.view.bringSubviewToFront(view)
        
        let safeGuide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -20),
            view.heightAnchor.constraint(equalToConstant: 50),
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            view.removeFromSuperview()
        }
    }
}
extension MainViewController: MenuViewControllerDelegate {
    func openStorage() {
        self.closeSideBar(animate: true) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: StorageViewController.sbId)
            (self.contentVC as? UINavigationController)?.pushViewController(vc!, animated: false)
        }
    }
    
    func openHistory() {
        self.closeSideBar(animate: true) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: HistoryViewController.sbId)
            (self.contentVC as? UINavigationController)?.pushViewController(vc!, animated: false)
        }
    }
    
    func openChangeCalc() {
        self.closeSideBar(animate: true) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: PositionViewController.sbId)
            (self.contentVC as? UINavigationController)?.pushViewController(vc!, animated: false)
        }
    }
}
