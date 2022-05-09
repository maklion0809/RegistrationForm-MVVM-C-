//
//  SignUpViewController.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import UIKit

protocol SignUpViewInterfaceDelegate: AnyObject {
    func resignAllResponders()
    func handlingError(message: String)
}

final class SignUpViewController: UIViewController, SignUpViewInterfaceDelegate {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let inputDataSpacing: CGFloat = 30
        static let controllerSpacing: CGFloat = 100
        static let textFieldBorderWidth: CGFloat = 1
        static let textFieldCornerRadius: CGFloat = 5
        static let buttonCornerRadius: CGFloat = 15
        static let textFieldHeight: CGFloat = 50
        static let controllerIndent: CGFloat = 30
    }
    
    // MARK: - Variable
    
    var viewModel: SignUpViewModelInterface?
    
    // MARK: - UI element
    
    private lazy var inputDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Configuration.inputDataSpacing
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
    
    private lazy var confirmPasswordTextField = UITextField()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = Configuration.buttonCornerRadius
        button.clipsToBounds = true
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        view.backgroundColor = .white
        viewModel?.signUpViewDelegate = self
        setupSubview()
        setupConstraint()
        setupTextField()
    }
    
    // MARK: - SignUpViewInterface
    
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
        inputDataStackView.addArrangedSubview(confirmPasswordTextField)
        
        controllerStackView.addArrangedSubview(inputDataStackView)
        controllerStackView.addArrangedSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        
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
        
        loginTextField.heightAnchor.constraint(equalToConstant: Configuration.textFieldHeight).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: Configuration.textFieldHeight).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: Configuration.textFieldHeight).isActive = true
    }
    
    // MARK: - Setting up the textField
    
    private func setupTextField() {
        let textField = [loginTextField, passwordTextField, confirmPasswordTextField]
        let placeholderTextField = ["Login", "Password", "Confirm password"]
        for (index, textField) in textField.enumerated() {
            textField.delegate = self
            textField.placeholder = placeholderTextField[index]
            textField.layer.borderWidth = Configuration.textFieldBorderWidth
            textField.layer.cornerRadius = Configuration.textFieldCornerRadius
            textField.layer.borderColor = UIColor.systemGray5.cgColor
        }
        confirmPasswordTextField.isSecureTextEntry = true
        passwordTextField.isSecureTextEntry = true
    }
    
    // MARK: - UIAction
    
    @objc private func signUpButtonAction() {
        viewModel?.handleSignUpButtonAction()
    }
}

// MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case loginTextField:
            viewModel?.usernameDidChange(with: textField.text)
        case passwordTextField:
            viewModel?.passwordDidChange(with: textField.text)
        case confirmPasswordTextField:
            viewModel?.confirmPasswordDidChange(with: textField.text)
        default:
            break
        }
    }
}


