//
//  Presenter.swift
//  CleverTestCoreData
//
//

import Foundation
import DogLib

final class MainPresenter {
    private let dogLibrary: DogLibrary
    weak var view: MainViewProtocol?

    init(dogLibrary: DogLibrary) {
        self.dogLibrary = dogLibrary
    }
}

// MARK: - MainPresenterProtocol
extension MainPresenter: MainPresenterProtocol {
    func loadDogsAction(count: Int) {
        view?.showLoading(true)
        dogLibrary.getImages(number: count) { [weak self] imageDatas in
            DispatchQueue.main.async {
                self?.view?.showLoading(false)
            }
        }
    }

    func nextAction() {
        self.view?.setPreviousButtonHidden(false)
        view?.showLoading(true)
        dogLibrary.getNextImage { [weak self] image in
            DispatchQueue.main.async {
                self?.view?.showLoading(false)

                if let image = image {
                    self?.view?.showImage(image)
                }
            }
        }
    }

    func previousAction() {
        dogLibrary.getPreviousImage{ [weak self] image, isFirst in
            DispatchQueue.main.async {
                if let image = image {
                    self?.view?.showImage(image)
                }
                self?.view?.setPreviousButtonHidden(isFirst)
            }
        }
    }

    func viewIsReady() {
        self.view?.setPreviousButtonHidden(true)
        view?.showLoading(true)
        dogLibrary.getNextImage { [weak self] image in
            DispatchQueue.main.async {
                self?.view?.showLoading(false)
                
                if let image = image {
                    self?.view?.showImage(image)
                }
            }
        }
    }
}
