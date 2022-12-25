//
//  NetworkManagerImpl.swift
//  CleverTestCoreData
//
//

import Foundation
import Alamofire

final class NetworkService {
    private let randomDogImage = "https://dog.ceo/api/breeds/image/random"
}

// MARK: - NetworkManagerProtocol
extension NetworkService: NetworkServiceProtocol {
    func loadRandomDog(completion: @escaping (Result<DogResponse, AFError>) -> Void) {
        guard let url = URL(string: randomDogImage) else { return }
        AF.request(url).responseDecodable(of: DogResponse.self) { response in
            completion(response.result)
        }
    }

    func loadRandomDogs(count: Int, completion: @escaping (Result<MultipleDogResponse, AFError>) -> Void) {
        let urlPath = randomDogImage + "/\(count)"
        guard let url = URL(string: urlPath) else { return }
        AF.request(url).responseDecodable(of: MultipleDogResponse.self) { response in
            completion(response.result)
        }
    }

    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
