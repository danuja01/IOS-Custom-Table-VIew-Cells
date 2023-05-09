//
//  SongsTableViewCell.swift
//  danuja.customCell
//
//  Created by danuja Jayasuriya on 4/28/23.
//

import UIKit


class SongsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songNameCellLabel: UILabel!
    @IBOutlet weak var songAuthorCellLabel: UILabel!
    @IBOutlet weak var songThumbnailCellImg: UIImageView!
    
    var blurredImageView: UIImageView!
    private var blurEffect: UIBlurEffect!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBlurredImageView()
        roundedConers()
    }
    
    private func setupBlurredImageView() {
        blurEffect = UIBlurEffect(style: .regular)
        blurredImageView = UIImageView(frame: contentView.bounds)
        blurredImageView.contentMode = .scaleAspectFill
        blurredImageView.clipsToBounds = true
        blurredImageView.layer.masksToBounds = true
        blurredImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = contentView.bounds // Update the frame here
        
        blurredImageView.addSubview(blurView)
        
        contentView.addSubview(blurredImageView)
        contentView.sendSubviewToBack(blurredImageView)
    }

    private func roundedConers() {
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }
}
