//
//  NetworkManager.swift
//  CleverTestCoreData
//
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func loadRandomDog(completion: @escaping (Result<DogResponse, AFError>) -> Void)
    func loadRandomDogs(count: Int, completion: @escaping (Result<MultipleDogResponse, AFError>) -> Void)
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}
