//
//  CustomAnimations.swift
//  MovieDex
//
//  Created by Luis Becerra on 4/12/24.
//

import UIKit

extension UIView {
    func shake() {
        let offset: CGFloat = 10
        UIView.animate(
            withDuration: 0.1, delay: 0, options: [.autoreverse, .repeat],
            animations: {
                UIView.modifyAnimations(withRepeatCount: 2, autoreverses: true)
                {
                    self.transform = CGAffineTransform(
                        translationX: -offset, y: 0)
                }
            }
        ) { _ in
            self.transform = .identity
        }
    }

}
