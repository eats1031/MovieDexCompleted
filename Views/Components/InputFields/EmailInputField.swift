//
//  EmailInputField.swift
//  MovieDex
//
//  Created by Luis Becerra on 29/11/24.
//

import UIKit

class EmailInputField: BaseTextField {

    init() {
        super.init(label: "Email Address")
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.keyboardType = .emailAddress
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.validate = {
            value in
            let emailRegex =
                "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
            let emailPredicate = NSPredicate(
                format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: value)
        }
    }
}
