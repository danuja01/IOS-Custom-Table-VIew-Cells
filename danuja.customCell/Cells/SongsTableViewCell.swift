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
    
    func configure(with song: Song?) {
        if let song = song {
            
            // Set up the cell with the actual song data
            songNameCellLabel?.text = song.name
            songAuthorCellLabel?.text = song.genre
            
            // Download and set the image for the cell
            APIManager.shared.downloadImage(from: song.image) { image in
                DispatchQueue.main.async {
                    self.songThumbnailCellImg?.image = image
                    self.blurredImageView?.image = image
                }
            }
        } else {
            songThumbnailCellImg?.image = UIImage(named: "placeholder_image")
            songNameCellLabel?.text = "..."
            songAuthorCellLabel?.text = "..."
        }
    }
    
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
