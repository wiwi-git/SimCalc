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
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell_id_history")
        }
        if let item = self.fetchResult?[indexPath.row] {
            cell.detailTextLabel?.text = item.date?.toString()
            cell.textLabel?.text = self.fetchResult?[indexPath.row].log
        }
        
        return cell
    }
}
