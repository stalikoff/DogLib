//
//  MainAssembly.swift
//  CleverDog_Example
//
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import DogLib

final class MainAssembly {
    static func createModule() -> UIViewController {
        let dogManager = DogLibrary()
        let presenter = MainPresenter(dogLibrary: dogManager)
        let viewController = MainViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
