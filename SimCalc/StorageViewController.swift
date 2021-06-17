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
}
