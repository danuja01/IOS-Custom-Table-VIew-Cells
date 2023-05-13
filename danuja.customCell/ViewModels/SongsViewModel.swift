import Foundation

class SongsViewModel: NSObject {
    
    private var apiManager: APIManager!
    private(set) var songs: [Song] = [] {
        didSet {
            self.bindSongsViewModelToController()
        }
    }
    
    var bindSongsViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiManager = APIManager.shared
        fetchSongs()
    }
    
    func fetchSongs() {
        self.apiManager.fetchSongs { [weak self] result in
            switch result {
            case .success(let songs):
                self?.songs = songs
            case .failure(let error):
                print("Error fetching songs: \(error.localizedDescription)")
            }
        }
    }
    
    func addSong(song: Song, completion: @escaping (Bool) -> Void) {
        self.apiManager.postSong(song: song) { result in
            switch result {
            case .success(let success):
                if success {
                    // Song was successfully added, invoke the completion handler with success as true
                    completion(true)
                } else {
                    print("Failed to add song.")
                    completion(false)
                }
            case .failure(let error):
                print("Error adding song: \(error.localizedDescription)")
                completion(false)
            }
        }
    }


}
