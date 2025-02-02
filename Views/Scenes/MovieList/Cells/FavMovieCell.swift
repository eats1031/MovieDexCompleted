//
//  MovieCell.swift
//  MovieDex
//
//  Created by Luis Becerra on 10/12/24.
//

import UIKit

class FavMovieCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var picture: RemoteImageView = {
        let remoteImageView = RemoteImageView(
            path: "", fillMode: .scaleAspectFill)
        remoteImageView.clipsToBounds = true
        print("Aspect Ratio in Pixels: \(180 )")
        remoteImageView.translatesAutoresizingMaskIntoConstraints = false

        return remoteImageView
    }()

    private lazy var releaseLabel: UILabel = {
        let label = ExtraSmallLabel(text: "")
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = SmallTitleLabel(text: "")
        return label
    }()

    private lazy var genresLabel: UILabel = {
        let label = ExtraSmallLabel(text: "")
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.titleLabel, self.genresLabel, self.releaseLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: 8, left: 10, bottom: 12, right: 10)
        stackView.spacing = 4
        return stackView
    }()

    private lazy var backdrop: RemoteImageView = {
        let remoteImageView = RemoteImageView(
            path: "", fillMode: .scaleAspectFill)
        remoteImageView.clipsToBounds = true
        remoteImageView.translatesAutoresizingMaskIntoConstraints = false
        return remoteImageView
    }()

    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(
            style: traitCollection.userInterfaceStyle == .dark ? .dark : .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.infoStackView.bounds
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()

    @objc private func handleAppearanceChange() {
        if traitCollection.userInterfaceStyle == .dark {
            self.blurEffectView.effect = UIBlurEffect(style: .dark)
        } else {
            self.blurEffectView.effect = UIBlurEffect(style: .light)
        }
    }

    override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?
    ) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(
            comparedTo: previousTraitCollection)
        {
            if traitCollection.userInterfaceStyle == .dark {
                self.blurEffectView.effect = UIBlurEffect(style: .dark)
            } else {
                self.blurEffectView.effect = UIBlurEffect(style: .light)
            }
        }
    }

    private func setupView() {

        self.picture.didSetupImage = { image in
            guard let image = image else { return }

            print(
                "Imagen cargada con tamaño ajustado: \(image.size) y aspect ratio: \(image.aspectRatio)"
            )
        }
        backgroundColor = .clear

        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false

        self.clipsToBounds = true

        self.addSubview(self.picture)
        self.addSubview(self.backdrop)
        self.addSubview(self.blurEffectView)
        self.addSubview(self.infoStackView)
        NSLayoutConstraint.activate([


            self.picture.topAnchor.constraint(equalTo: self.topAnchor),
            self.picture.bottomAnchor.constraint(equalTo: self.infoStackView.topAnchor),
            self.picture.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.picture.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.infoStackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor),
            self.infoStackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            self.infoStackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),

            self.backdrop.topAnchor.constraint(
                equalTo: self.infoStackView.topAnchor),
            self.backdrop.bottomAnchor.constraint(
                equalTo: self.infoStackView.bottomAnchor),
            self.backdrop.leadingAnchor.constraint(
                equalTo: self.infoStackView.leadingAnchor),
            self.backdrop.trailingAnchor.constraint(
                equalTo: self.infoStackView.trailingAnchor),

            self.blurEffectView.topAnchor.constraint(
                equalTo: self.infoStackView.topAnchor),
            self.blurEffectView.bottomAnchor.constraint(
                equalTo: self.infoStackView.bottomAnchor),
            self.blurEffectView.leadingAnchor.constraint(
                equalTo: self.infoStackView.leadingAnchor),
            self.blurEffectView.trailingAnchor.constraint(
                equalTo: self.infoStackView.trailingAnchor),
        ])
    }

    func updateWith(_ item: Movie) {
        self.picture.updatePath(path: item.posterPath)
        self.backdrop.updatePath(path: item.backdropPath)
        self.titleLabel.text = item.originalTitle
        self.releaseLabel.text = item.releaseDateFormatted
        self.genresLabel.text = item.genresList
    }
}
