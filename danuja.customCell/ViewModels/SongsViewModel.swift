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
}
