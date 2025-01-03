//
//  MovieListView.swift
//  MovieDex
//
//  Created by Luis Becerra on 15/11/24.
//

import SwiftUI
import UIKit

class MovieListView: UIView {
    
    weak var delegate: MovieListViewDelegate?
    private var movieAdapter: MovieAdapter

    init(movieAdapter: MovieAdapter) {
        self.movieAdapter = movieAdapter
        super.init(frame: .zero)
        self.movieAdapter = movieAdapter
        self.movieAdapter.setCollectionView(self.collectionView)
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateMovies(_ movies: [Movie]) {
        //print("Movies from controller(\(movies.count)): \(movies)")
        self.movieAdapter.items = movies
        self.collectionView.reloadData()
    }
    
    func updateGenresById(_ genresById: [Int: Genre]) {
        self.movieAdapter.genresById = genresById
        self.collectionView.reloadData()
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func addElements() {
        self.backgroundColor = .background
        self.addSubview(self.searchBar)
        self.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)  
        ])
    }
}

extension MovieListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

// MARK: - Preview SwiftUI
struct MovieListViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> MovieListView {
        let movieAdapter = MovieListAdapter()
        let view = MovieListView(movieAdapter: movieAdapter)
        return view
    }

    func updateUIView(_ uiView: MovieListView, context: Context) {

    }
}

#Preview {
    MovieListViewRepresentable()
}
