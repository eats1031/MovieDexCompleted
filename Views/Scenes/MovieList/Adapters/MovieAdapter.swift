//
//  CollectionAdapter.swift
//  MovieDex
//
//  Created by Luis Becerra on 10/12/24.
//

import UIKit

protocol MovieAdapter {
    func setCollectionView(_ collectionView: UICollectionView)
    var items: [Movie] { get set }
    var genresById: [Int: Genre] { get set }
    var itemsPerRow: Int { get set }
    var itemsPerColumn: Int { get set }
    var cellHeight: CGFloat { get set }
    var columnSpacing: CGFloat { get set }
    var rowSpacing: CGFloat { get set }
}

// MARK: - Compositional Layout
extension MovieAdapter {
    func buildLayout() -> UICollectionViewCompositionalLayout {
        let numberOfColumns: Int = itemsPerRow
        let fractionalWidth: CGFloat = 1 / CGFloat(numberOfColumns)

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fractionalWidth),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: itemsPerColumn != -1
                ? .fractionalHeight(1 / CGFloat(itemsPerColumn))
                : .estimated(cellHeight))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, repeatingSubitem: item,
            count: numberOfColumns)
        group.interItemSpacing = .fixed(columnSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = rowSpacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16, leading: 16, bottom: 16, trailing: 16)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
