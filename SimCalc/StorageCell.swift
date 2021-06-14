//
//  MemoCell.swift
//  SimCalc
//
//  Created by 위대연 on 2021/06/14.
//

import UIKit

class StorageCell: UITableViewCell {
    static let reuseId = "cell_id_storagecell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var memoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dateLabel.text = ""
        self.logTextView.text = ""
        self.memoLabel.text = ""
    }

}
