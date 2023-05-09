//
//  ViewController.swift
//  danuja.customCell
//
//  Created by danuja Jayasuriya on 4/28/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var songsViewModel: SongsViewModel!
    
    @IBOutlet weak var songsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SONGS"
        
        // Instantiate the SongsViewModel
        callToSongsViewModel()
        
        
        // Set up table view
        songsTableView.delegate = self
        songsTableView.dataSource = self
        
        
        
    }
    
    func callToSongsViewModel() {
        self.songsViewModel = SongsViewModel()
        
        songsViewModel.bindSongsViewModelToController = { [weak self] in
            DispatchQueue.main.async {
                self?.songsTableView.reloadData()
            }
        }
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
        return songsViewModel.songs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Each section has only one row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songCell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongsTableViewCell
        
        let section = indexPath.section
        let song = songsViewModel.songs[section]
        
        songCell.songThumbnailCellImg?.image = UIImage(named: "placeholder_image")
        
        // Download and set the image for the cell
        APIManager.shared.downloadImage(from: song.image) { image in
            DispatchQueue.main.async {
                songCell.songThumbnailCellImg?.image = image
                songCell.blurredImageView.image = image
            }
        }
        
        // Set up the cell's UI
        songCell.songNameCellLabel?.text = song.name
        songCell.songAuthorCellLabel?.text = song.genre
        
        return songCell
    }
}

