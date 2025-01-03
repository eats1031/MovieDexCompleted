//
//  EmailInputField.swift
//  MovieDex
//
//  Created by Luis Becerra on 29/11/24.
//

import UIKit

class PasswordInputField: BaseTextField {
    
    private lazy var toggleButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        button.tintColor = .text
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    init() {
        super.init(label: "Password")
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.textPadding.right = 50
        self.isSecureTextEntry = true
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.validate = { value in
            return value.count >= 4
        }
        
        self.rightView = toggleButton
        self.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
            isSecureTextEntry.toggle()
            let newImageName = isSecureTextEntry ? "eye" : "eye.slash"

            // Animación para cambiar el SF Symbol
            UIView.transition(
                with: toggleButton,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: {
                    self.toggleButton.setImage(UIImage(systemName: newImageName), for: .normal)
                },
                completion: nil
            )
        }
}
