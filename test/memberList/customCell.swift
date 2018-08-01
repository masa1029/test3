//
//  customCell.swift
//  
//
//  Created by きしもつ on 2018/07/25.
//

import UIKit

class customCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var cellSubTitle: UILabel!
    
    @IBOutlet weak var goodButton: UIButton!//★★★★★★★★★★★★★★★★★★★★これ書いてなかったセルのいいねボタン
}
