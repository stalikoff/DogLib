//
//  ViewController.swift
//  CleverTestCoreData
//
//

import UIKit
import Alamofire
import ProgressHUD

private enum Constants {
    static let minLoadCount: Int = 0
    static let maxLoadCount: Int = 10
    static let buttonHeight: CGFloat = 50
    static let buttonBorderColor = UIColor.lightGray
    static let elementsCornerRadius: CGFloat = 10
}

final class MainViewController: UIViewController {
    private let presenter: MainPresenterProtocol

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.layer.borderColor = Constants.buttonBorderColor.cgColor
        button.layer.cornerRadius = Constants.elementsCornerRadius
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return button
    }()

    private lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Previous", for: .normal)
        button.layer.borderColor = Constants.buttonBorderColor.cgColor
        button.layer.cornerRadius = Constants.elementsCornerRadius
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(previousAction), for: .touchUpInside)
        return button
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.elementsCornerRadius
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = Constants.buttonBorderColor.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.textAlignment = .center
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .numberPad
        textfield.placeholder = "Enter dogs count"
        textfield.delegate = self
        return textfield
    }()

    private lazy var loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load", for: .normal)
        button.layer.borderColor = Constants.buttonBorderColor.cgColor
        button.layer.cornerRadius = Constants.elementsCornerRadius
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(loadAction), for: .touchUpInside)
        return button
    }()

    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewIsReady()
    }
}

// MARK: - Private methods
extension MainViewController {
    private func setup() {
        view.backgroundColor = .white
        setupPreviousButton()
        setupNextButton()
        setupImageView()
        setupLoadButton()
        setupTextField()
        setupGestureRecognizer()
    }
}

// MARK: - Actions
extension MainViewController {
    @objc private func loadAction() {
        guard let loadCount = Int(textfield.text ?? ""),
              loadCount > Constants.minLoadCount, loadCount <= Constants.maxLoadCount else { return }
        dismissKeyboard()
        textfield.text = ""
        presenter.loadDogsAction(count: loadCount)
    }

    @objc private func nextAction() {
        presenter.nextAction()
    }

    @objc private func previousAction() {
        presenter.previousAction()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func showLoading(_ isShow: Bool) {
        DispatchQueue.main.async {
            if isShow {
                ProgressHUD.show()
            } else {
                ProgressHUD.dismiss()
            }
        }
    }

    func setPreviousButtonHidden(_ isHidden: Bool) {
        self.previousButton.isHidden = isHidden
    }

    func showImage(_ image: UIImage) {
        self.imageView.image = image
    }
}

// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if newText.isEmpty {
            return true
        }
        else if let intValue = Int(newText), intValue > 0, intValue <= Constants.maxLoadCount {
            return true
        }
        return false
    }
}

// MARK: - Layout
extension MainViewController {
    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    private func setupLoadButton() {
        view.addSubview(loadButton)
        NSLayoutConstraint.activate([
            loadButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            loadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            loadButton.widthAnchor.constraint(equalToConstant: 100),
            loadButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }

    private func setupTextField() {
        view.addSubview(textfield)
        NSLayoutConstraint.activate([
            textfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textfield.rightAnchor.constraint(equalTo: loadButton.leftAnchor, constant: -20),
            textfield.centerYAnchor.constraint(equalTo: loadButton.centerYAnchor),
            textfield.heightAnchor.constraint(equalTo: loadButton.heightAnchor),
        ])
    }

    private func setupImageView() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }

    private func setupPreviousButton() {
        view.addSubview(previousButton)
        NSLayoutConstraint.activate([
            previousButton.widthAnchor.constraint(equalToConstant: 150),
            previousButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            previousButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }

    private func setupNextButton() {
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}
