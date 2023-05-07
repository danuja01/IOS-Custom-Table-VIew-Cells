//
//  SongsTableViewCell.swift
//  danuja.customCell
//
//  Created by danuja Jayasuriya on 4/28/23.
//

import UIKit


class SongsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songNameCellLabel:UILabel!
    @IBOutlet weak var songAuthorCellLabel:UILabel!
    @IBOutlet weak var songThumbnailCellImg:UIImageView!
    @IBOutlet weak var cellBackdrop:UIImageView!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        songThumbnailCellImg?.image = UIImage(named: "placeholder_image") // Replace "placeholder_image" with the name of your placeholder image in assets folder
    }




}

