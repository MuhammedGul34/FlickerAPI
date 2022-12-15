//
//  PhotoDetailViewController.swift
//  FlickrClientApp
//
//  Created by Muhammed Gül on 14.12.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ownerImageView: UIImageView!
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo Detail"
        imageView.backgroundColor = .gray
        ownerImageView.backgroundColor = .gray
        ownerNameLabel.text = "Owner Name"
        descriptionLabel.text = "Description Label Description Label Description Label Description Label Description Label"
    }
}
