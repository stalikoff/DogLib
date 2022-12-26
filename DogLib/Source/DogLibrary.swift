//
//  DogLibrary.swift
//  CleverTest
//
//

import Foundation
import Alamofire

/// DogLibrary loads random dog images from API and save it to database.
public final class DogLibrary {
    private lazy var databaseManager: DatabaseServiceProtocol = DatabaseService()
    private lazy var networkManager: NetworkServiceProtocol = NetworkService()
    private var currentImageIndex: Int = -1

    public init() { }

    /// Removes images from the database
    public func clearSavedImages() {
        databaseManager.removeAll()
    }

    /// Loads a random dog image from the API and saves to the database
    public func getImage(completion: @escaping (Result<Data, DogError>) -> ()) {
        networkManager.loadRandomDog { [weak self, currentImageIndex] result in
            switch result {
            case .success(let response):
                if let imagePath = response.message, let url = URL(string: imagePath) {
                    self?.networkManager.getImageData(from: url, completion: { imageData, response, error in
                        if let imageData = imageData {
                            self?.databaseManager.saveImageData(imageData, atIndex: currentImageIndex)
                            completion(.success(imageData))
                            return
                        }
                    })
                } else {
                    completion(.failure(.mappingError))
                }

            case .failure(_):
                completion(.failure(.networkError))
            }
        }
    }

    /// Loads number of a random dog images from the API and saves to the database
    public func getImages(number: Int, completion: @escaping (Result<[Data], DogError>) -> ()) {
        networkManager.loadRandomDogs(count: number) { [weak self] result in
            switch result {
            case .success(let response):
                var imageDatas = [Data]()
                response.message?.forEach { path in
                    if let url = URL(string: path), let data = try? Data(contentsOf: url) {
                        imageDatas.append(data)
                    }
                }

                if !imageDatas.isEmpty {
                    self?.databaseManager.saveImageDatas(imageDatas, startIndex: self?.currentImageIndex ?? 0)
                    completion(.success(imageDatas))
                } else {
                    completion(.failure(.networkError))
                }

            case .failure(_):
                completion(.failure(.networkError))
            }
        }
    }

    /// Returns the previous dog image
    public func getPreviousImage(completion: @escaping (Result<(image: UIImage, isFirst: Bool), DogError>) -> Void) {
        if currentImageIndex <= 0 {
            completion(.failure(.previousImageNilError))
            return
        }

        currentImageIndex -= 1
        databaseManager.getImage(atIndex: currentImageIndex) { [weak self] imageData in
            guard let strongSelf = self else { return }
            let isFirst = strongSelf.currentImageIndex == 0
            if let imageData = imageData, let image = UIImage(data: imageData) {
                completion(.success((image, isFirst)))
            } else {
                completion(.failure(.mappingError))
            }
        }
    }

    /// Returns the next dog image from Database or load it from API
    public func getNextImage(completion: @escaping (Result<UIImage, DogError>) -> Void) {
        currentImageIndex += 1
        databaseManager.getImage(atIndex: currentImageIndex) { [weak self] imageData in
            if let imageData = imageData, let image = UIImage(data: imageData) {
                completion(.success(image))
            } else {
                self?.getImage(completion: { result in
                    switch result {
                    case .success(let data):
                        if let image = UIImage(data: data) {
                            completion(.success(image))
                        } else {
                            completion(.failure(.mappingError))
                        }

                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            }
        }
    }
}
