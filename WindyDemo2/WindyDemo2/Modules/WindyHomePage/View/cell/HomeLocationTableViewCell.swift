//
//  HomeLocationTableViewCell.swift
//  WindyDemo2
//
//  Created by Thuan Nguyen on 16/02/2022.
//

import UIKit
import MGSwipeTableCell

class HomeLocationTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var imvWeather: UIImageView!
    @IBOutlet weak var imvWind: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
