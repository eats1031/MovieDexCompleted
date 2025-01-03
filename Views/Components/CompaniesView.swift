//
//  CompaniesView.swift
//  MovieDex
//
//  Created by Luis Becerra on 26/11/24.
//

import UIKit
import SwiftUI

class CompaniesView: UIView {
    private var logos: [String] = []

    init(logos: [String]) {
        self.logos = logos
        super.init(frame: .zero)
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 32
        return stackView
    }()

    private func addElements() {
        self.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        self.addLogos()
    }

    private func removeLogos() {
        self.stackView.arrangedSubviews.forEach { view in
            self.stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    private func addLogos() {
        removeLogos()
        logos.forEach { logo in
            let imageView = RemoteImageView(path: logo, fillMode: .scaleAspectFit, hideIfUrlIsEmpty: true)
            imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            self.stackView.addArrangedSubview(imageView)
        }
    }

    func updateLogos(logos: [String]) {
        self.logos = logos
        self.addLogos()
    }
}

// MARK: - Preview SwiftUI
struct CompaniesViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CompaniesView {
        let view = CompaniesView(logos: MovieDetail(dto: MovieDetailDto.mock).logosFromProductionCompanies)
        return view
    }

    func updateUIView(_ uiView: CompaniesView, context: Context) {

    }
}

#Preview {
    CompaniesViewRepresentable()
}
