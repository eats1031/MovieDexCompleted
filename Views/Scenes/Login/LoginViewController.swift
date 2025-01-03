//
//  MovieDetailViewController.swift
//  MovieDex
//
//  Created by Luis Becerra on 19/11/24.
//

import UIKit

class LoginViewController: UIViewController {
    private let layoutView: LoginView
    private let keyboardManager: KeyboardManager

    init(layoutView: LoginView) {
        self.layoutView = layoutView
        self.keyboardManager = KeyboardManager(view: layoutView)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        keyboardManager.initialOriginY = self.view.frame.origin.y
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutView.centerView()
        self.keyboardManager.contentToShowMaxY = self.layoutView.getFormMaxY
    }

    private func configureView() {
        self.view = self.layoutView
        self.layoutView.delegate = self
    }
    
    private func validateCredentialsWith(email: String, password: String) {
        if email == "asd@asd.asd"
            && password == "asdasd"
        {
            print("Credentials valid")
        } else {
            self.layoutView.onLoginFail()
        }
    }
}

// MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func submitValidatedFields(email: String, password: String) {
        validateCredentialsWith(email: email, password: password)
    }
}

// MARK: - Builder
extension LoginViewController {
    class func build() -> LoginViewController {
        let view = LoginView()
        let controller = LoginViewController(layoutView: view)
        return controller
    }
}
