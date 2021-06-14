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
        self.navigationItem.title = "계산 기록"
        
        let request: NSFetchRequest<History> = History.fetchRequest()
        self.fetchResult = HistoryManager.shared.fetch(request: request)
        
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
            cell.detailTextLabel?.text = item.date?.toString()
            cell.textLabel?.text = self.fetchResult?[indexPath.row].log
        }
        
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { (action, v, complet:@escaping (Bool) -> Void) in
            
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
