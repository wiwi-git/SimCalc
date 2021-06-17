//
//  HistoryViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/06/09.
//

import UIKit
import CoreData
class HistoryViewController: UIViewController{
    static let sbId = "sb_id_historyviewcontroller"
    
    @IBOutlet weak var tableView:UITableView!
    
    var fetchResult:[History]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationItem.title = "계산 기록"
        self.navigationController?.navigationBar.tintColor = .white
        
        let request: NSFetchRequest<History> = History.fetchRequest()
        self.fetchResult = HistoryManager.shared.fetch(request: request)
        
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
extension HistoryViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "cell_id_history") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell_id_history")
        }
        if let item = self.fetchResult?[indexPath.row] {
            cell.detailTextLabel?.text = self.fetchResult?[indexPath.row].log
            cell.textLabel?.text = item.date?.toString()
        }
        cell.detailTextLabel?.textColor = .white
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let saveAction = UIContextualAction(style: .normal, title: "보관함으로") { (action, v, complet:@escaping (Bool) -> Void) in
            
            let alert = UIAlertController(title: "보관함으로", message: "메모를 적어 저장하세요.", preferredStyle: .alert)
            alert.addTextField { (tf) in
                tf.placeholder = "메모 내용"
            }
            alert.addAction(UIAlertAction(title: "저장", style: .default, handler: { (_) in
                if let item = self.fetchResult?[indexPath.row],
                   let date = item.date,
                   let log = item.log {
                    let calcLog = CalcLog(date: date, log: log)
                    var memo: String = ""
                    if let tfs = alert.textFields,
                       let tf = tfs.first,
                       let text = tf.text {
                        memo = text
                    }
                    let result = HistoryManager.shared.insertStorage(log: calcLog, memo: memo)
                    let toastMessage = result ? "SUCCESS" : "저장에 실패했습니다."
                    
                    if let parentVc = self.parent,
                       let navigation = parentVc as? UINavigationController,
                       let parentToNavigation = navigation.parent,
                       let mainVC = parentToNavigation as? MainViewController {
                        mainVC.showToast(message: toastMessage, time: 3)
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        saveAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [
                                            saveAction])
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                var toastMessage:String = "삭제에 실패했습니다."
                var result = false
                if let item = self.fetchResult?.remove(at: indexPath.row) {
                    result = HistoryManager.shared.delete(object: item)
                }
                if result {
                    toastMessage = "SUCCESS"
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    tableView.endUpdates()
                }
                DispatchQueue.main.async {
                    if let parentVc = self.parent,
                       let navigation = parentVc as? UINavigationController,
                       let parentToNavigation = navigation.parent,
                       let mainVC = parentToNavigation as? MainViewController {
                        mainVC.showToast(message: toastMessage, time: 3)
                    }
                }
            default: print("o")
        }
    }
    /*
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { (action, v, complet:@escaping (Bool) -> Void) in
            let alert = UIAlertController(title: "삭제", message: "정말 지우시겠습니까?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "삭제", style: .default, handler: { (_) in
                if let item = self.fetchResult?[indexPath.row] {
                    let result = HistoryManager.shared.delete(object: item)
                    var toastMessage:String = "삭제에 실패했습니다."
                    if result {
                        toastMessage = "SUCCESS"
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                    
                    if let parentVc = self.parent,
                       let navigation = parentVc as? UINavigationController,
                       let parentToNavigation = navigation.parent,
                       let mainVC = parentToNavigation as? MainViewController {
                        mainVC.showToast(message: toastMessage, time: 3)
                    }
                }
                tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }*/
}
