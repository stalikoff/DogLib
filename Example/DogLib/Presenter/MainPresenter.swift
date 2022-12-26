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
        dogLibrary.getNextImage { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.view?.showLoading(false)
                    self?.view?.showImage(image)
                case .failure(let error):
                    self?.view?.showError(error.message)
                }
            }
        }
    }

    func previousAction() {
        dogLibrary.getPreviousImage{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let typle):
                    self?.view?.showImage(typle.image)
                    self?.view?.setPreviousButtonHidden(typle.isFirst)

                case .failure(let error):
                    self?.view?.showError(error.message)
                }
            }
        }
    }

    func viewIsReady() {
        self.view?.setPreviousButtonHidden(true)
        view?.showLoading(true)
        dogLibrary.getNextImage { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.view?.showLoading(false)
                    self?.view?.showImage(image)
                case .failure(let error):
                    self?.view?.showError(error.message)
                }
            }
        }
    }
}
