import Foundation

class SongsViewModel: NSObject {
    
    private var apiManager: APIManager!
    private var currentPage = 1
     var isLastPage = false
    var isLoadingData = false

    private(set) var songs: [Song] = [] {
        didSet {
            self.bindSongsViewModelToController?()
        }
    }
    
    var bindSongsViewModelToController: (() -> Void)?
    
    override init() {
        super.init()
        self.apiManager = APIManager.shared
        fetchSongs()
    }

    
    func fetchSongs() {
        guard !isLoadingData && !isLastPage else {
            return // To prevent multiple concurrent fetch
        }
        
        isLoadingData = true
        
        DispatchQueue.global().asyncAfter(deadline: .now()+1, execute: {
            self.apiManager.fetchSongs(page: self.currentPage) { [weak self] result in
                switch result {
                case .success(let songs):
                    DispatchQueue.main.async {
                        if songs.isEmpty {
                            self?.isLastPage = true
                        } else {
                            self?.songs.append(contentsOf: songs)
                            self?.currentPage += 1 // Increment the current page
                        }
                        self?.bindSongsViewModelToController?()
                    }
                case .failure(let error):
                    print("Error fetching songs: \(error.localizedDescription)")
                }
                
                self?.isLoadingData = false
            }
        })
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
