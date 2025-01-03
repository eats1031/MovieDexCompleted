//
//  GradientView.swift
//  MovieDex
//
//  Created by Luis Becerra on 26/11/24.
//

import UIKit

class GradientView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        self.isOpaque = false
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        let colors =
            [
                UIColor.clear.cgColor,
                UIColor.background.cgColor
            ] as CFArray

        let locations: [CGFloat] = [0.0, 1.0]

        guard
            let gradient = CGGradient(
                colorsSpace: CGColorSpaceCreateDeviceRGB(),
                colors: colors,
                locations: locations)
        else { return }

        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
        let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
        context.drawLinearGradient(
            gradient, start: startPoint, end: endPoint, options: [])
    }
}
