import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = URL(string: "https://songsapi-production.up.railway.app/api/songs")!
    
    /* ALAMOFIRE */
    
    func fetchSongs(completion: @escaping (Result<[Song], Error>) -> Void) {
        AF.request(baseURL).responseDecodable(of: ResponseData.self) { response in
            switch response.result {
            case .success(let decodedData):
                let allSongs = decodedData.data
//                let firstTenSongs = Array(allSongs.prefix(10))
                completion(.success(allSongs))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func postSong(song:Song, completion: @escaping (Result<Bool, Error>) -> Void) {
        let data: [String: String] = [
            "name" : song.name,
            "genre" : song.genre,
            "image" : song.image
        ]
        
        AF.request(baseURL, method: .post, parameters: data, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        AF.request(imageURL).responseData { response in
            switch response.result {
            case .success(let data):
                completion(UIImage(data: data))
            case .failure(_):
                completion(nil)
                print("Image Download Error!")
            }
        }
        
    }
    
    /* URL SESSIONS */
    
    //    func fetchSongs(completion: @escaping (Result<[Song], Error>) -> Void) {
    //        let request = URLRequest(url: baseURL)
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, _, error in
    //            guard let data = data, error == nil else {
    //                completion(.failure(error ?? NSError(domain: "Data Error", code: 0, userInfo: nil)))
    //                return
    //            }
    //
    //            do {
    //                // Create a custom decoding container to extract the "data" field
    //                let decodedData = try JSONDecoder().decode(ResponseData.self, from: data)
    //
    //                let allSongs = decodedData.data
    //
    //                //                 Extract the first 20 songs
    //                let firstSongs = Array(allSongs.prefix(20))
    //
    //                completion(.success(firstSongs))
    //
    //            } catch {
    //                completion(.failure(error))
    //                print(String(describing: error))
    //            }
    //        }
    //        task.resume()
    //    }
    //
    
    
    
    /* DOWNLOAD IMAGE : URLSESSION */
    
    //    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
    //        guard let imageURL = URL(string: url) else {
    //            completion(nil)
    //            return
    //        }
    //
    //        URLSession.shared.dataTask(with: imageURL) { data, response, error in
    //            guard let data = data, error == nil else {
    //                completion(nil)
    //                return
    //            }
    //
    //            let image = UIImage(data: data)
    //            completion(image)
    //        }.resume()
    //    }
    
    
}
