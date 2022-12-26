//
//  DogViewProtocol.swift
//  CleverTestCoreData
//
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func showImage(_ image: UIImage)
    func setPreviousButtonHidden(_ isHidden: Bool)
    func showLoading(_ isShow: Bool)
    func showError(_ error: String)
}
