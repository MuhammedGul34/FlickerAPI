//
//  PhotoTableViewCell.swift
//  FlickrClientApp
//
//  Created by Muhammed Gül on 14.12.2022.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ownerImageView: UIImageView!
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ownerImageView.layer.cornerRadius = 24.0
        // Configure the view for the selected state
    }

}
