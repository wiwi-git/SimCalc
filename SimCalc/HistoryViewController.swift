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
        self.navigationItem.title = "History"
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
            cell.detailTextLabel?.text = item.date?.toString()
            cell.textLabel?.text = self.fetchResult?[indexPath.row].log
        }
        cell.detailTextLabel?.textColor = .white
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        cell.backgroundColor = .clear
        return cell
    }
 
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let saveAction = UIContextualAction(style: .normal, title: "SAVE") { (action, v, complet:@escaping (Bool) -> Void) in
            
            let alert = UIAlertController(title: "Saved in Storage", message: "Put in Text", preferredStyle: .alert)
            alert.addTextField { (tf) in
                tf.placeholder = "Text"
            }
            alert.addAction(UIAlertAction(title: "SAVE", style: .default, handler: { (_) in
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
                    let toastMessage = result ? "SUCCESS" : "FAIL"
                    
                    if let parentVc = self.parent,
                       let navigation = parentVc as? UINavigationController,
                       let parentToNavigation = navigation.parent,
                       let mainVC = parentToNavigation as? MainViewController {
                        mainVC.showToast(message: toastMessage, time: 3)
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        var saveImage = UIImage(named: "saveImage")
        saveImage = saveImage?.withTintColor(.white, renderingMode: .alwaysTemplate)
        saveAction.backgroundColor = UIColor(named: "tableSwipeMenuBackground")
        saveAction.image = saveImage

        return UISwipeActionsConfiguration(actions: [saveAction])
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (action, v, complet:@escaping (Bool) -> Void) in
            var toastMessage:String = "FAIL"
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
        }
        let deleteImage = UIImage(named: "deleteImage")!
        deleteAction.image = deleteImage.paintOver(with: .red)
        deleteAction.backgroundColor = UIColor(named: "tableSwipeMenuBackground")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
