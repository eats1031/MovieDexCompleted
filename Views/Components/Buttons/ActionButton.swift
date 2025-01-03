//
//  ActionButton.swift
//  MovieDex
//
//  Created by Luis Becerra on 26/11/24.
//

import UIKit

class ActionButton: UIView {
    var text: String
    var iconName: String
    var onTap: (() -> Void)?

    private var iconImageView: UIImageView
    private var titleLabel: UILabel

    init(text: String, iconName: String, onTap: (() -> Void)? = nil) {
        self.text = text
        self.iconName = iconName
        self.onTap = onTap
        titleLabel = UILabel()
        iconImageView = UIImageView()
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .text
        iconImageView.widthAnchor.constraint(equalToConstant: .init(30)).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: .init(30)).isActive = true

        titleLabel = SmallTextLabel(text: text)

        let stackView = UIStackView(arrangedSubviews: [
            iconImageView, titleLabel,
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        let tapGesture = UITapGestureRecognizer(
            target: self, action: #selector(buttonTapped))
        addGestureRecognizer(tapGesture)
    }

    @objc private func buttonTapped() {
        if let onTap { onTap() }

    }
}
