//
//  StarsView.swift
//  MovieDex
//
//  Created by Luis Becerra on 25/11/24.
//

import UIKit

public class StarsStackView: UIStackView {
    private var totalStars: Int = 5
    private let originalVoteScale: Int = 10
    private var vote: Double
    private var starSize: CGFloat

    private var voteScale: Double {
        self.vote * Double(self.totalStars) / Double(self.originalVoteScale)
    }

    private var filledStars: Int {
        return Int(floor(self.voteScale))
    }

    private var isHalfStar: Bool {
        self.voteScale - Double(self.filledStars) >= 0.5
    }

    init(totalStars: Int = 10, vote: Double, starSize: CGFloat = 24) {
        self.totalStars = totalStars
        self.vote = vote
        self.starSize = starSize
        super.init(frame: .zero)
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 10
        self.addElements()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addElements() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addStars()
    }

    private func addStars() {
        for i in 1...totalStars {
            let star = UIImageView(
                image: UIImage(
                    systemName: i <= self.filledStars
                        ? "star.fill"
                        : i == self.filledStars + 1 && isHalfStar
                            ? "star.leadinghalf.filled" : "star"))
            star.tintColor = .draculaYellow
            star.contentMode = .scaleAspectFit
            star.translatesAutoresizingMaskIntoConstraints = false
            star.heightAnchor.constraint(equalToConstant: self.starSize).isActive = true
            star.widthAnchor.constraint(equalToConstant: self.starSize).isActive = true
            self.addArrangedSubview(star)
        }
    }

    private func clearStars() {
        for view in self.arrangedSubviews {
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    func updateVote(vote: Double) {
        self.vote = vote
        clearStars()
        addStars()
    }
}
