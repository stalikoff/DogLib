//
//  DatabaseManagerProtocol.swift
//  CleverTestCoreData
//
//

import Foundation

protocol DatabaseServiceProtocol {
    func removeAll()
    func saveImageData(_ imageData: Data, atIndex: Int)
    func saveImageDatas(_ imageDataArray: [Data], startIndex: Int)
    func getImage(atIndex: Int, completion: @escaping (Data?) -> ())
}
