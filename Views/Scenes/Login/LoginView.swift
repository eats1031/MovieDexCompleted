//
//  LoginView.swift
//  MovieDex
//
//  Created by Luis Becerra on 28/11/24.
//

import SwiftUI
import UIKit

class LoginView: UIView {
    private var isFormValid: Bool = false
    weak var delegate: LoginViewDelegate?

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .background
        addElements()
        setupInputNavigation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInputNavigation(){
        self.emailInputField.returnKeyType = .next
        self.emailInputField.onReturnPress = {
            self.passwordInputField.becomeFirstResponder()
        }
        self.passwordInputField.returnKeyType = .send
        self.passwordInputField.onReturnPress = {
            self.submitForm()
        }
    }
    
    private func didPressReturn(){
        
    }

    var getFormMaxY: CGFloat {
        let emailHelperHeight =
            emailInputFieldHelperText.isHidden
            ? 0 : emailInputFieldHelperText.frame.height
        let passwordHelperHeight =
            passwordInputFieldHelperText.isHidden
            ? 0 : passwordInputFieldHelperText.frame.height
        return self.inputsStack.convert(self.inputsStack.bounds, to: nil).maxY
            + emailHelperHeight + passwordHelperHeight
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // ========== START: Header ==========

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LogoLarge"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var infoLabel: SmallTextLabel = {
        let label = SmallTextLabel(
            text: "Enter your account email address and password")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private lazy var headerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.logoImage, self.infoLabel,
        ])
        stackView.axis = .vertical
        stackView.spacing = 48
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // ========== END: Header ==========

    // ========== START: Input Fields ==========

    private lazy var emailInputField = {
        let inputField = EmailInputField()
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.addTarget(
            self, action: #selector(onTextFieldChange), for: .editingDidBegin)
        inputField.addTarget(
            self, action: #selector(onTextFieldChange), for: .editingChanged)
        inputField.addTarget(
            self, action: #selector(onTextFieldChange), for: .editingDidEnd)
        return inputField
    }()

    private lazy var emailInputFieldHelperText: SmallTextLabel = {
        let label = SmallTextLabel(text: "Please enter a valid email address.")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .error
        label.isHidden = true
        return label
    }()

    private lazy var emailInputStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.emailInputField, self.emailInputFieldHelperText,
        ])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var passwordInputField = {
        let inputField = PasswordInputField()
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.addTarget(
            self, action: #selector(onTextFieldChange), for: .editingDidBegin)
        inputField.addTarget(
            self, action: #selector(onTextFieldChange), for: .editingChanged)
        inputField.addTarget(
            self, action: #selector(onTextFieldChange), for: .editingDidEnd)
        return inputField
    }()

    private lazy var passwordInputFieldHelperText: SmallTextLabel = {
        let label = SmallTextLabel(
            text:
                "Password must be at least 4 characters long."
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .error
        label.isHidden = true
        return label
    }()

    private lazy var passwordInputStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.passwordInputField, self.passwordInputFieldHelperText,
        ])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var submitButton: BaseButton = {
        let button = BaseButton(text: "Sign In", iconName: "sparkles")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self, action: #selector(submitForm), for: .touchUpInside)
        return button
    }()

    private lazy var submitHelperText: SmallTextLabel = {
        let label = SmallTextLabel(
            text: "Login failed. Please check your credentials.")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .draculaYellow
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    private lazy var submitStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.submitButton, self.submitHelperText,
        ])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var inputsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.emailInputStack, self.passwordInputStack, self.submitStack,
        ])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: 36, left: 0, bottom: 30, right: 0)
        return stackView
    }()

    // ========== END: Input Fields ==========

    // ========== START: Options ==========

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Open Sans Bold", size: 16)
        button.setTitleColor(UIColor.draculaPurple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = UIFont(name: "Open Sans Bold", size: 16)
        button.setTitleColor(UIColor.draculaPurple, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var optionsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.forgotPasswordButton, self.signUpButton,
        ])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // ========== END: Options ==========

    // ========== START: Main Stack ==========

    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.headerStack, self.inputsStack, self.optionsStack,
        ])
        stackView.axis = .vertical
        stackView.spacing = (0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(
            top: 48, left: 20, bottom: 20, right: 20)
        return stackView
    }()

    lazy var mainStackTopAnchor: NSLayoutConstraint = {
        NSLayoutConstraint(
            item: self.mainStack,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.scrollView,
            attribute: .top,
            multiplier: 1,
            constant: 0)
    }()

    // ========== END: Main Stack  ==========

    private func addElements() {
        self.addSubview(self.scrollView)
        scrollView.addSubview(self.mainStack)

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(
                equalTo: self.topAnchor),
            self.scrollView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),

            self.mainStackTopAnchor,
            self.mainStack.leadingAnchor.constraint(
                equalTo: self.scrollView.leadingAnchor),
            self.mainStack.trailingAnchor.constraint(
                equalTo: self.scrollView.trailingAnchor),
            self.mainStack.bottomAnchor.constraint(
                equalTo: self.scrollView.bottomAnchor),
            self.mainStack.widthAnchor.constraint(
                equalTo: self.scrollView.widthAnchor),

        ])
    }

    func centerView() {
        let scrollViewHeight = self.scrollView.frame.height
        let mainStackHeight = self.mainStack.frame.height

        if mainStackHeight < scrollViewHeight {
            let deltaY = (scrollViewHeight - mainStackHeight) / 2
            self.mainStackTopAnchor.constant = deltaY
            self.layoutIfNeeded()
            self.setNeedsLayout()
        }
    }

    private func validateForm() -> Bool {
        return
            !self.emailInputField.isPristine && self.emailInputField.isValid
            && !self.passwordInputField.isPristine
            && self.passwordInputField.isValid
    }

    @objc private func onTextFieldChange(_ sender: UITextField) {
        self.submitHelperText.isHidden = true
        
        switch sender {
        case self.emailInputField:
            self.emailInputFieldHelperText.isHidden =
                (sender as! BaseTextField).isValid
        case self.passwordInputField:
            self.passwordInputFieldHelperText.isHidden =
                (sender as! BaseTextField).isValid
        default:
            break
        }
    }

    @objc func submitForm() {
        self.submitHelperText.isHidden = true
        self.emailInputField.endEditing(true)
        self.passwordInputField.endEditing(true)
        self.emailInputField.forceValidation()
        self.passwordInputField.forceValidation()
        self.emailInputFieldHelperText.isHidden = emailInputField.isValid
        self.passwordInputFieldHelperText.isHidden = passwordInputField.isValid
        if validateForm() {
            if let delegate = self.delegate, let email = self.emailInputField.text, let password = self.passwordInputField.text {
                delegate.submitValidatedFields(email: email, password: password)
            }
            
        } else {
            self.emailInputFieldHelperText.shake()
            self.passwordInputFieldHelperText.shake()
        }
    }
    
    func onLoginFail() {
        self.submitHelperText.isHidden = false
        self.emailInputField.shake()
        self.passwordInputField.shake()
    }
}

// MARK: - Preview SwiftUI
struct LoginViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> LoginView {
        let view = LoginView()
        return view
    }

    func updateUIView(_ uiView: LoginView, context: Context) {

    }
}

#Preview {
    LoginViewRepresentable()
}
