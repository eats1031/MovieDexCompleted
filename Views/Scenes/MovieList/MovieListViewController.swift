//
//  MovieListViewController.swift
//  Beta2MovieDex
//
//  Created by Edwin Asmed Tejada Sacristan on 25/12/24.
//

import UIKit

class MovieListViewController: UIViewController, MovieListViewDelegate {
    let movieService: MovieService
    let movieListView: MovieListView
    var genresById: [Int: Genre] = [:]

    init(movieListView: MovieListView, movieService: MovieService) {
        self.movieListView = movieListView
        self.movieService = movieService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func getGenres() {
        Task {
            do {
                self.genresById = try await GlobalGenresManager.shared
                    .fetchGlobalGenres()
            } catch {
                print("Error al obtener los géneros: \(error)")
                self.genresById = [:]
            }
            movieListView.updateGenresById(self.genresById)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    private func fetchMovies() {
        Task {
            do {
                let fetchedMovies = try await movieService.fetchMovies()
                let movies = fetchedMovies.map({ movieDto in
                    Movie(dto: movieDto)
                })
                movieListView.updateMovies(movies)
            } catch {
                print("An error occurs loading movies. Error: \(error)")
            }
        }
    }

    func configureView() {
        self.view = self.movieListView
        self.movieListView.delegate = self
        getGenres()
        fetchMovies()
    }
}

// MARK: - Delegate Methods
extension MovieListViewController {
    func example(movies: [Movie]) {

    }
}

// MARK: - Builder
extension MovieListViewController {
    class func popularMovieListBuild() -> MovieListViewController {
        let adapter = MovieListAdapter()
        let view = MovieListView(movieAdapter: adapter)
        let movieService = MovieService()

        let controller = MovieListViewController(
            movieListView: view, movieService: movieService)
        return controller
    }
    
    class func favoritesMovieListBuild() -> MovieListViewController {
        let adapter = FavMovieListAdapter()
        let view = MovieListView(movieAdapter: adapter)
        let movieService = MovieService()

        let controller = MovieListViewController(
            movieListView: view, movieService: movieService)
        return controller
    }
}
