import Foundation
import UIKit

class APIManager {
    static let shared = APIManager()

    private let baseURL = URL(string: "http://172.28.0.23:4000/api/songs")!
    
    func fetchSongs(completion: @escaping (Result<[Song], Error>) -> Void) {
        let request = URLRequest(url: baseURL)

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Data Error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                // Create a custom decoding container to extract the "data" field
                let decodedData = try JSONDecoder().decode(ResponseData.self, from: data)
                let allSongs = decodedData.data
                
                // Extract the first 10 songs
                let firstTenSongs = Array(allSongs.prefix(20))
                
                completion(.success(firstTenSongs))
            } catch {
                completion(.failure(error))
                print(String(describing: error))
            }
        }
        task.resume()
    }

    
    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }


}
