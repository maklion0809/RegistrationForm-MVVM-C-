//
//  SignInViewController.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import UIKit

protocol SignInViewInterfaceDelegate: AnyObject {
    func resignAllResponders()
    func handlingError(message: String)
}

final class SignInViewController: UIViewController, SignInViewInterfaceDelegate {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let inputDataSpacing: CGFloat = 30
        static let navigationSpacing: CGFloat = 30
        static let controllerSpacing: CGFloat = 100
        static let textFieldBorderWidth: CGFloat = 1
        static let textFieldCornerRadius: CGFloat = 5
        static let buttonCornerRadius: CGFloat = 15
        static let textFieldHeight: CGFloat = 50
        static let controllerIndent: CGFloat = 30
    }
    
    // MARK: - View model
    
    var viewModel: SignInViewModelInterface?
    
    // MARK: - UI element
    
    private lazy var inputDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Configuration.inputDataSpacing
        
        return stackView
    }()
    
    private var navigationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Configuration.navigationSpacing
        
        return stackView
    }()
    
    private var controllerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Configuration.controllerSpacing
        
        return stackView
    }()
    
    private lazy var loginTextField = UITextField()
    private lazy var passwordTextField = UITextField()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = Configuration.buttonCornerRadius
        button.clipsToBounds = true
        
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = Configuration.buttonCornerRadius
        button.clipsToBounds = true
        
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .white
        viewModel?.signInViewDelegate = self
        setupSubview()
        setupConstraint()
        setupTextField()
    }
    
    // MARK: - SignInViewInterface
    
    func resignAllResponders() {
        view.endEditing(true)
    }
    
    func handlingError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        inputDataStackView.addArrangedSubview(loginTextField)
        inputDataStackView.addArrangedSubview(passwordTextField)
        
        navigationStackView.addArrangedSubview(signInButton)
        signInButton.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        navigationStackView.addArrangedSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        
        
        controllerStackView.addArrangedSubview(inputDataStackView)
        controllerStackView.addArrangedSubview(navigationStackView)
        
        view.addSubview(controllerStackView)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        controllerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controllerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Configuration.controllerIndent),
            controllerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Configuration.controllerIndent),
            controllerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        passwordTextField.heightAnchor.constraint(equalToConstant: Configuration.textFieldHeight).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: Configuration.textFieldHeight).isActive = true
    }
    
    // MARK: - Setting up the textField
    
    private func setupTextField() {
        let textField = [loginTextField, passwordTextField]
        let placeholderTextField = ["Login", "Password"]
        for (index, textField) in textField.enumerated() {
            textField.delegate = self
            textField.placeholder = placeholderTextField[index]
            textField.layer.borderWidth = Configuration.textFieldBorderWidth
            textField.layer.cornerRadius = Configuration.textFieldCornerRadius
            textField.layer.borderColor = UIColor.systemGray5.cgColor
        }
        passwordTextField.isSecureTextEntry = true
    }
    
    // MARK: - UIAction
    
    @objc private func signInButtonAction() {
        viewModel?.handleSignInAction()
    }
    
    @objc private func signUpButtonAction() {
        viewModel?.handleSignUpAction()
    }
}

// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case loginTextField:
            viewModel?.loginDidChange(textField.text)
        case passwordTextField:
            viewModel?.passwordDidChange(textField.text)
        default: break
        }
    }
}
