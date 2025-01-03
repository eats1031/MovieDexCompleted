//
//  MovieDetailViewController.swift
//  MovieDex
//
//  Created by Luis Becerra on 19/11/24.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailViewDelegate {
    let movieId: Int
    let service: MovieDetailService
    let layoutView: MovieDetailView

    init(detailView: MovieDetailView, service: MovieDetailService, movieId: Int)
    {
        self.layoutView = detailView
        self.service = service
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    func configureView() {
        self.view = self.layoutView
        self.layoutView.delegate = self
        fetchMovieDetail(movieId: self.movieId)
    }

    private func fetchMovieDetail(movieId: Int) {
        Task {
            do {
                var movieDetail: MovieDetail
                let fetchedMovieDetail = try await service.fetchMovieDetail(
                    id: movieId)
                if let fetchedMovieDetail {
                    movieDetail = MovieDetail(dto: fetchedMovieDetail)
                } else {
                    movieDetail = MovieDetail(dto: MovieDetailDto.empty)
                    //TODO show error alert message, that returns to home screen.
                }
                layoutView.updateMovieDetail(movieDetail: movieDetail)
            } catch {
                print("An error occurs loading movies. Error: \(error)")
                //TODO show error alert message, that returns to home screen.
            }
        }
    }
}

// MARK: - Delegate Methods
extension MovieDetailViewController {
    func example(movies: [Movie]) {

    }
}

// MARK: - Builder
extension MovieDetailViewController {
    class func build(movieId: Int) -> MovieDetailViewController {
        let view = MovieDetailView()
        let service = MovieDetailService()
        let controller = MovieDetailViewController(
            detailView: view, service: service, movieId: movieId)
        return controller
    }
}
