//
//  ArtistsTableViewCell.swift
//  LyrixApp
//
//  Created by Disni Sriyaratna on 5/26/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class ArtistsTableViewCell: UITableViewCell {

    @IBOutlet weak var artistsImage: UIImageView!
    @IBOutlet weak var artistsName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
