//
//  FindTableViewCell.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/10.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit

class FindTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    var model: TestModel? {
        didSet {
            self.headerImageView.setImage(model?.pic51, AssetsImageNames.placeHodelName)
            self.nameLabel.text = model?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
