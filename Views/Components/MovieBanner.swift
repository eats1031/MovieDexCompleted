//
//  MovieBannerView.swift
//  MovieDex
//
//  Created by Luis Becerra on 19/11/24.
//

import SwiftUI
import UIKit

class MovieBanner: UIView {
    private var title: String
    private var subtitle: String
    private var genre: String
    private var imagePath: String

    private lazy var bannerImg: RemoteImageView = {
        let remoteImg = RemoteImageView(path: imagePath)
        return remoteImg
    }()

    private lazy var gradientView: GradientView = {
        let gradientView = GradientView()
        return gradientView
    }()

    private lazy var titleLabel: TitleLabel = {
        let titleLabel = TitleLabel(text: title)
        return titleLabel
    }()

    private lazy var subtitleLabel: SubTitleLabel = {
        let subTitleLabel = SubTitleLabel(text: subtitle)
        return subTitleLabel
    }()

    private lazy var genreLabel: SmallTextLabel = {
        let genreLabel = SmallTextLabel(text: genre)
        return genreLabel
    }()

    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, subtitleLabel, genreLabel,
        ])
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()

    init(title: String, subtitle: String?, imagePath: String, genre: String) {
        self.title = title
        self.subtitle = subtitle ?? ""
        self.imagePath = imagePath
        self.genre = genre
        super.init(frame: .zero)
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addElements() {
        self.backgroundColor = .background
        self.addSubview(self.bannerImg)
        self.addSubview(self.gradientView)
        self.addSubview(self.titleStack)

        self.bannerImg.translatesAutoresizingMaskIntoConstraints = false
        self.gradientView.translatesAutoresizingMaskIntoConstraints = false
        self.titleStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.bannerImg.topAnchor.constraint(equalTo: self.topAnchor),
            self.bannerImg.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            self.bannerImg.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),
            self.bannerImg.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            self.gradientView.heightAnchor.constraint(
                equalTo: self.heightAnchor, multiplier: 0.64),
            self.gradientView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            self.gradientView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),
            self.gradientView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor),

            self.titleStack.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 20),
            self.titleStack.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: 20),
            self.titleStack.bottomAnchor.constraint(
                equalTo: self.bottomAnchor, constant: -32),
        ])
    }
    func updateContent(title: String, subtitle: String?, imagePath: String, genre: String) {
        self.title = title
        self.subtitle = subtitle ?? ""
        self.imagePath = imagePath
        self.genre = genre

        // Actualiza las vistas internas
        titleLabel.updateContent(self.title)
        subtitleLabel.updateContent(self.subtitle)
        genreLabel.updateContent(self.genre)
        bannerImg.updatePath(path: imagePath)
    }
}

// MARK: - Preview SwiftUI
struct MovieBannerViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> MovieBanner {
        let view = MovieBanner(
            title: "Venom: The Last Dance",
            subtitle: "'Til death do they part.",
            imagePath: "/vq340s8DxA5Q209FT8PHA6CXYOx.jpg",
            genre: "Horror, Fantasy, Action")
        return view
    }

    func updateUIView(_ uiView: MovieBanner, context: Context) {

    }
}

#Preview {
    MovieBannerViewRepresentable()
}
