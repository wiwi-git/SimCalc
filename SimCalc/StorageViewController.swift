//
//  StorageViewController.swift
//  SimCalc
//
//  Created by 위대연 on 2021/06/14.
//

import UIKit

class StorageViewController: UIViewController {
  static let sbId = "sb_id_storage"
  
  @IBOutlet weak var tableview: UITableView!
  
  var fetchResult:[Memo]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let bar = self.navigationController?.navigationBar
    bar?.tintColor = .white
    bar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    self.navigationItem.title = "저장소"
    
    self.tableview.delegate = self
    self.tableview.dataSource = self
    self.tableview.register(UINib(nibName: "StorageCell", bundle: nil), forCellReuseIdentifier: StorageCell.reuseId)
    self.tableview.backgroundColor = .clear
    self.fetchResult = HistoryManager.shared.fetch(request: Memo.fetchRequest())
  }

}
extension StorageViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchResult?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: StorageCell.reuseId, for: indexPath) as! StorageCell
    if let item = self.fetchResult?[indexPath.row] {
      cell.dateLabel.text = item.date?.toString()
      cell.logTextView.text = item.log
      cell.memoLabel.text = item.memo
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
      case .delete:
        let alert = UIAlertController(title: "삭제", message: "정말 지우시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "삭제", style: .default, handler: { (_) in
          var result = false
          if let item = self.fetchResult?.remove(at: indexPath.row) {
              result = HistoryManager.shared.delete(object: item)
          }
          
          var toastMessage:String = "삭제에 실패했습니다."
          if result {
            toastMessage = "SUCCESS"
            self.tableview.beginUpdates()
            self.tableview.deleteRows(at: [indexPath], with: .automatic)
            self.tableview.endUpdates()
          }
          if let parentVc = self.parent,
             let navigation = parentVc as? UINavigationController,
             let parentToNavigation = navigation.parent,
             let mainVC = parentToNavigation as? MainViewController {
            mainVC.showToast(message: toastMessage, time: 3)
          }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
      case .insert: print("i")
      default: print("o")
    }
  }
}
