import Foundation
import UIKit

class APIManager {
    static let shared = APIManager()

    private let baseURL = URL(string: "https://6450bb4de1f6f1bb229d949a.mockapi.io/songs")!
    
    func fetchData(completion: @escaping (Result<[Song], Error>) -> Void) {
        let request = URLRequest(url: baseURL)

        let task = URLSession.shared.dataTask(with: request) {
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //Convert to JSON
            do {
                let songs = try JSONDecoder().decode([Song].self, from: data)
                completion(.success(songs))
            }catch {
                completion(.failure(error))
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
