//
//  BaseButton.swift
//  MovieDex
//
//  Created by Luis Becerra on 25/11/24.
//

import UIKit

class BaseButton: UIButton {
    private var text: String?
    private var iconName: String?
    private var onTap: (() -> Void)?

    init(
        text: String? = nil, iconName: String? = nil, onTap: (() -> Void)? = nil
    ) {
        self.text = text
        self.iconName = iconName
        self.onTap = onTap
        super.init(frame: .zero)
        configureButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureButton() {
        var configuration = UIButton.Configuration.filled()

        configuration.baseBackgroundColor = .draculaPurple
        configuration.baseForegroundColor = .text
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 12, leading: 16, bottom: 12, trailing: 16)

        if let text = self.text {
            var attributedTitle = AttributedString(text)
            attributedTitle.font =
                UIFont(name: "Open Sans Bold", size: 16)
                ?? UIFont.systemFont(ofSize: 16)
            attributedTitle.foregroundColor = .text
            configuration.attributedTitle = attributedTitle
        }

        if let iconName = self.iconName {
            configuration.image = UIImage(systemName: iconName)
            configuration.imagePadding = 16
        }

        self.configuration = configuration
        self.layer.cornerRadius = 20
        self.sizeToFit()
        self.addAction(
            UIAction(handler: { _ in
                self.handleTap()
            }), for: .touchUpInside)
    }

    private func handleTap() {
        self.onTap?()
    }

    func updateCallback(_ callback: (() -> Void)?) {
        self.onTap = callback
    }
}
