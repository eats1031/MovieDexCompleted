//
//  CollectionAdapter.swift
//  MovieDex
//
//  Created by Luis Becerra on 10/12/24.
//

import UIKit

class FavMovieListAdapter: NSObject, MovieAdapter {
    private weak var collectionView: UICollectionView?
    var items: [Movie] = []
    var genresById: [Int: Genre] = [:]
    var itemsPerRow: Int = 2
    var itemsPerColumn: Int = -1
    var cellHeight: CGFloat = 320
    var rowSpacing: CGFloat = 10
    var columnSpacing: CGFloat = 12

    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        setupCollectionView()
    }

    private func setupCollectionView() {
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(
            FavMovieCell.self,
            forCellWithReuseIdentifier: String(describing: FavMovieCell.self)
        )
        self.collectionView?.collectionViewLayout = buildLayout()
        print(
            "Registrando celda con identificador: \(String(describing: FavMovieCell.self))"
        )
    }
}

// MARK: - UICollectionViewDataSource
extension FavMovieListAdapter: UICollectionViewDataSource {

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
                withReuseIdentifier: String(describing: FavMovieCell.self),
                for: indexPath) as? FavMovieCell
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
extension FavMovieListAdapter: UICollectionViewDelegate {

}
