//
//  MovieTabController.swift
//  MovieDex
//
//  Created by Luis Becerra on 18/12/24.
//
import UIKit

class MovieTabController: UITabBarController {
    private var blurEffectView: UIVisualEffectView

    init() {
        let blurEffect = UIBlurEffect(style: .dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.tabBar.isTranslucent = true  // Efecto translúcido
        self.tabBar.tintColor = .tabbarItem  // Íconos seleccionados
        self.tabBar.unselectedItemTintColor = .gray

        let blurEffect = UIBlurEffect(
            style: traitCollection.userInterfaceStyle == .dark ? .dark : .light)
        self.blurEffectView.effect = blurEffect
        self.blurEffectView.frame = self.tabBar.bounds
        self.blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight,
        ]

        // Agregar el efecto de desenfoque al TabBar
        self.tabBar.insertSubview(blurEffectView, at: 0)

        configureControllers()
    }

    private func configureControllers() {
        let movieListVC = MovieListViewController.popularMovieListBuild()
        movieListVC.title = "Movies"
        movieListVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let favMovieListVC = MovieListViewController.favoritesMovieListBuild()
        favMovieListVC.title = "Favorites"
        favMovieListVC.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        viewControllers = [movieListVC, favMovieListVC]
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
}

extension MovieTabController {
    static func build() -> MovieTabController {
        MovieTabController()
    }
}
