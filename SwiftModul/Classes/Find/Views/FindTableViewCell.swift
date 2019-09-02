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
    
    public func configureCell(data: ProductInfoProtocal) {
        headerImageView.setImage(data.imageUrl, "")
        nameLabel.text = data.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
