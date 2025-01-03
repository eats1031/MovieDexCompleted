//
//  Divider.swift
//  MovieDex
//
//  Created by Luis Becerra on 29/11/24.
//
 
import UIKit

class Divider: UIView {
    init(color: UIColor = .lightGray, height: CGFloat = 1.0) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
