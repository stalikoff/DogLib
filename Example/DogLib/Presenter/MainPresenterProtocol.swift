//
//  DogPresenterProtocol.swift
//  CleverTestCoreData
//
//

import Foundation

protocol MainPresenterProtocol {
    func viewIsReady()
    func previousAction()
    func nextAction()
    func loadDogsAction(count: Int)
}
