//
//  EpisodeTableViewCell.swift
//  Screencast
//
//  Created by Neil García on 7/14/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import UIKit
import SDWebImage

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(title: String, subTitle: String, imageURL: URL) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
         episodeImage.sd_setImage(with: imageURL , placeholderImage: UIImage(named: ""))
        // Fill the image with url
    }
    

}
