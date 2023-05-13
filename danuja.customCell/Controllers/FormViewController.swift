import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var genre: UITextField!
    @IBOutlet weak var image: UITextField!
    
    private var songsViewModel: SongsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        genre.delegate = self
        image.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        songsViewModel = SongsViewModel()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case genre:
            name.becomeFirstResponder()
        case name:
            image.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton)  {
        guard let name = name.text, !name.isEmpty,
              let genre = genre.text, !genre.isEmpty,
              let imageURL = image.text, !imageURL.isEmpty else {
            return
        }
        
        let song = Song(name: name, genre: genre, image: imageURL)
        
        songsViewModel.addSong(song: song) { success in
            if success {
                self.songsViewModel.fetchSongs()
            }else {
                print("Failed to add the song.")
            }
        }
        
        // Clear the text fields or perform any other necessary UI updates
        self.name.text = ""
        self.genre.text = ""
        self.image.text = ""
        
        
         if let tabBarViewController = self.tabBarController {
             tabBarViewController.selectedIndex = 0
         }
    }
    
}

