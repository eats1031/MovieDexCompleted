//
//  CollectionAdapter.swift
//  MovieDex
//
//  Created by Luis Becerra on 10/12/24.
//

import UIKit

class MovieListAdapter: NSObject, MovieAdapter {
    private weak var collectionView: UICollectionView?
    var items: [Movie] = []
    var genresById: [Int: Genre] = [:]
    var itemsPerRow: Int = 1
    var itemsPerColumn: Int = -1
    var cellHeight: CGFloat = 180
    var rowSpacing: CGFloat = 14
    var columnSpacing: CGFloat = 0

    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        setupCollectionView()
    }

    private func setupCollectionView() {
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(
            MovieCell.self,
            forCellWithReuseIdentifier: String(describing: MovieCell.self)
        )
        self.collectionView?.collectionViewLayout = buildLayout()
        print(
            "Registrando celda con identificador: \(String(describing: MovieCell.self))"
        )
    }
}



// MARK: - UICollectionViewDataSource
extension MovieListAdapter: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        self.items.count
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        var item = self.items[indexPath.row]
        let cell =
            self.collectionView?.dequeueReusableCell(
                withReuseIdentifier: String(describing: MovieCell.self),
                for: indexPath) as? MovieCell
        print("Celda obtenida correctamente")
        guard let cell else {
            print("Error al obtener la celda")
            return UICollectionViewCell()
        }
        item.genresList = item.genreIds.compactMap { id in
            self.genresById[id]?.name
        }.joined(separator: ", ")
        cell.updateWith(item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MovieListAdapter: UICollectionViewDelegate {

}
