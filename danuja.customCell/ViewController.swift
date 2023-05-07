//
//  ViewController.swift
//  danuja.customCell
//
//  Created by danuja Jayasuriya on 4/28/23.
//

import UIKit

class ViewController: UIViewController {
    
    var songs = [Song]()
    
    @IBOutlet weak var songsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch data using APIManager
        APIManager.shared.fetchData { result in
            switch result {
            case .success(let songs):
                // Populate the songs array with fetched data
                self.songs = songs
                DispatchQueue.main.async {
                    // Reload the table view with fetched data
                    self.songsTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        // Set up table view
        songsTableView.delegate = self
        songsTableView.dataSource = self

    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(13)
    }
    
}



extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Each section has only one row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songCell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongsTableViewCell
        
        let section = indexPath.section
        let song = songs[section]
        
        songCell.songThumbnailCellImg?.image = UIImage(named: "placeholder_image")

    
        
        
        // Create the blurred image view
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredImageView = UIImageView(frame: songCell.contentView.bounds)
        
        blurredImageView.contentMode = .scaleAspectFill
        blurredImageView.clipsToBounds = true
        blurredImageView.layer.masksToBounds = true
        blurredImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blurredImageView.image = UIImage(named: "placeholder_image")
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = blurredImageView.bounds
        blurredImageView.addSubview(blurView)
        
        // Download and set the image for the cell
        APIManager.shared.downloadImage(from: song.image) { image in
               DispatchQueue.main.async {
                   songCell.songThumbnailCellImg?.image = image
                   blurredImageView.image = image

                   
               }
        }
        
        // Set up the cell's UI
        songCell.backgroundView = UIView()
        songCell.backgroundView?.addSubview(blurredImageView)
        songCell.layer.cornerRadius = 12
        songCell.songNameCellLabel?.text = song.name
        songCell.songAuthorCellLabel?.text = song.genre
        
        
        return songCell
    }
}
