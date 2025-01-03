//
//  MovieDetailView.swift
//  MovieDex
//
//  Created by Luis Becerra on 19/11/24.
//

import SwiftUI
import UIKit

class MovieDetailView: UIView {
    private var movieDetail: MovieDetail

    private var onTrailerTap: (() -> Void)? = nil

    weak var delegate: MovieDetailViewDelegate?

    init(
        movieDetail: MovieDetail = MovieDetail(
            dto: MovieDetailDto.empty)
    ) {
        self.movieDetail = movieDetail
        super.init(frame: .zero)
        addElements()
        updateMovieDetail(movieDetail: movieDetail)
    }

    lazy var scrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    lazy var contentView = {
        let contentView = UIView()
        return contentView
    }()

    lazy var movieBanner = {
        let movieBanner = MovieBanner(
            title: self.movieDetail.title, subtitle: self.movieDetail.tagline,
            imagePath: self.movieDetail.posterPath,
            genre: self.movieDetail.genresString)
        return movieBanner
    }()

    lazy var durationLabel = {
        let smallTextLabel = SmallTextLabel(text: movieDetail.duration)
        smallTextLabel.updateAlignment(.right)
        return smallTextLabel
    }()

    lazy var releaseYearLabel = {
        let smallTextLabel = SmallTextLabel(
            text: movieDetail.releaseMonthYear)
        smallTextLabel.updateAlignment(.right)
        return smallTextLabel
    }()

    lazy var starsView = {
        let starsView = StarsStackView(vote: self.movieDetail.voteAverage)
        return starsView
    }()

    lazy var runtimeAndYearStack = {
        let stack = UIStackView(
            arrangedSubviews: [
                self.durationLabel, self.releaseYearLabel,
            ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()

    lazy var bannerInfo1 = {
        starsView.translatesAutoresizingMaskIntoConstraints = false
        let bannerInfo1 = UIStackView(
            arrangedSubviews: [
                self.starsView, self.runtimeAndYearStack,
            ])
        bannerInfo1.translatesAutoresizingMaskIntoConstraints = false
        bannerInfo1.axis = .horizontal
        bannerInfo1.distribution = .fill
        bannerInfo1.alignment = .center
        bannerInfo1.spacing = 20
        return bannerInfo1
    }()

    lazy var overviewLabel = {
        let smallTextLabel = MediumTextLabel(text: movieDetail.overview)
        smallTextLabel.updateAlignment(.justified)
        return smallTextLabel
    }()

    lazy var trailerButton: BaseButton = {
        let button = BaseButton(
            text: "Ver Trailer", iconName: "play.fill", onTap: self.onTrailerTap
        )
        return button
    }()

    lazy var addListButton: ActionButton = {
        let button = ActionButton(text: "Mi Lista", iconName: "heart")
        return button
    }()

    lazy var shareButton: ActionButton = {
        let button = ActionButton(
            text: "Compartir", iconName: "square.and.arrow.up")
        return button
    }()

    lazy var actionButtonsStack: UIStackView = {
        starsView.translatesAutoresizingMaskIntoConstraints = false
        let stack = UIStackView(
            arrangedSubviews: [
                self.addListButton, self.shareButton,
            ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 0
        return stack
    }()

    lazy var companiesView: CompaniesView = {
        let companiesView = CompaniesView(
            logos: movieDetail.logosFromProductionCompanies)
        return companiesView
    }()

    func updateMovieDetail(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
        movieBanner.updateContent(
            title: self.movieDetail.title, subtitle: self.movieDetail.tagline,
            imagePath: self.movieDetail.backdropPath,
            genre: self.movieDetail.genresString)
        self.durationLabel.updateContent(self.movieDetail.duration)
        self.releaseYearLabel.updateContent(self.movieDetail.releaseMonthYear)
        self.starsView.updateVote(vote: self.movieDetail.voteAverage)
        self.overviewLabel.updateContent(self.movieDetail.overview)
        self.companiesView.updateLogos(
            logos: self.movieDetail.logosFromProductionCompanies)

        self.onTrailerTap = {
            let trailerService = TrailerService()
            Task {
                do {
                    var trailers: [Trailer]
                    let fetchedTrailers =
                        try await trailerService.fetchTrailers(
                            id: self.movieDetail.id)

                    trailers = fetchedTrailers.compactMap { trailerDto in
                        Trailer(dto: trailerDto)
                    }

                    let trailer = trailers.first(where: { trailer in
                        trailer.site.lowercased() == "youtube"
                    })

                    if let trailer {
                        openYouTubeLink(videoId: trailer.key)
                    }

                } catch {
                    print("An error occurs loading trailers. Error: \(error)")
                    //TODO show error alert message, that returns to home screen.
                }
            }
        }
        
        self.trailerButton.updateCallback(self.onTrailerTap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addElements() {
        self.backgroundColor = .background

        self.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.movieBanner)
        self.movieBanner.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.bannerInfo1)
        self.bannerInfo1.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.trailerButton)
        self.trailerButton.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.actionButtonsStack)
        self.actionButtonsStack.translatesAutoresizingMaskIntoConstraints =
            false

        self.contentView.addSubview(self.overviewLabel)
        self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.companiesView)
        self.companiesView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(
                equalTo: self.topAnchor, constant: -64),
            self.scrollView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            self.movieBanner.topAnchor.constraint(
                equalTo: self.contentView.topAnchor),
            self.movieBanner.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor),
            self.movieBanner.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor),
            self.movieBanner.heightAnchor.constraint(
                equalTo: self.movieBanner.widthAnchor, multiplier: 1.25),

            self.bannerInfo1.topAnchor.constraint(
                equalTo: self.movieBanner.bottomAnchor, constant: 0),
            self.bannerInfo1.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 20),
            self.bannerInfo1.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor, constant: -20),

            self.trailerButton.topAnchor.constraint(
                equalTo: self.bannerInfo1.bottomAnchor, constant: 20),
            self.trailerButton.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 20),
            self.trailerButton.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor, constant: -20),

            self.actionButtonsStack.topAnchor.constraint(
                equalTo: self.trailerButton.bottomAnchor, constant: 20),
            self.actionButtonsStack.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 20),
            self.actionButtonsStack.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor, constant: -20),

            self.overviewLabel.topAnchor.constraint(
                equalTo: self.actionButtonsStack.bottomAnchor, constant: 20),
            self.overviewLabel.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 20),
            self.overviewLabel.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor, constant: -20),

            self.companiesView.topAnchor.constraint(
                equalTo: self.overviewLabel.bottomAnchor, constant: 32),
            self.companiesView.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor, constant: 20),
            self.companiesView.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor, constant: -20),
            self.companiesView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -20),

        ])
    }
}

// MARK: - Preview SwiftUI
struct MovieDetailViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> MovieDetailView {
        let movieDetail = MovieDetail(dto: MovieDetailDto.mock)
        let view = MovieDetailView(movieDetail: movieDetail)
        return view
    }

    func updateUIView(_ uiView: MovieDetailView, context: Context) {

    }
}

#Preview {
    MovieDetailViewRepresentable()
}
