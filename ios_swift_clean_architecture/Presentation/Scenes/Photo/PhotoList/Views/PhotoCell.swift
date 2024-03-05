//
//  PhotoCell.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 05/03/2024.
//

import UIKit

class PhotoCell: UITableViewCell {
    @IBOutlet weak var imageViewThumbnail: UIImageView!
    @IBOutlet weak var labelUser: UILabel!
    @IBOutlet weak var labelTags: UILabel!
    @IBOutlet weak var labelLikes: UILabel!
    @IBOutlet weak var labelComments: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelUser.numberOfLines = 1
        labelUser.lineBreakMode = .byWordWrapping
        labelTags.numberOfLines = 1
        labelTags.lineBreakMode = .byTruncatingTail
        labelLikes.numberOfLines = 1
        labelLikes.lineBreakMode = .byWordWrapping
        labelComments.numberOfLines = 1
        labelComments.lineBreakMode = .byWordWrapping
        imageViewThumbnail.layer.cornerRadius = 10
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
