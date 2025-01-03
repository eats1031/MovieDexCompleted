//
//  BaseLabel.swift
//  MovieDex
//
//  Created by Luis Becerra on 20/11/24.
//

import UIKit

class BaseLabel: UILabel {

    private var alignment: NSTextAlignment
    private var size: CGFloat
    private let initialSize: CGFloat
    private let color: UIColor
    private let isBold: Bool
    private let lines: Int
    private var padding: UIEdgeInsets

        init(
            text: String = "", size: CGFloat = 18, color: UIColor = .text,
            isBold: Bool = false, alignment: NSTextAlignment = .left, lines: Int = 0, padding: UIEdgeInsets = .zero
        ) {
            self.size = size
            self.color = color
            self.isBold = isBold
            self.alignment = alignment
            self.lines = lines
            self.padding = padding
            self.initialSize = size
            super.init(frame: .zero)
            self.text = text
            setupUI()
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.textColor = self.color
        self.font =
            isBold
            ? UIFont(name: "Open Sans Bold", size: size)
            : UIFont(name: "Open Sans", size: size)
        self.textAlignment = alignment
        self.numberOfLines = lines
        self.text = text
    }
    
    func resetSize(){
        self.size = initialSize
        updateSize(size: initialSize)
    }
    
    func updateSize(size: CGFloat){
        self.font =
            isBold
            ? UIFont(name: "Open Sans Bold", size: size)
            : UIFont(name: "Open Sans", size: size)
    }
    
    override var intrinsicContentSize: CGSize {
            let originalSize = super.intrinsicContentSize
            let width = originalSize.width + padding.left + padding.right
            let height = originalSize.height + padding.top + padding.bottom
            return CGSize(width: width, height: height)
        }
    
    override func drawText(in rect: CGRect) {
            let insetsRect = rect.inset(by: padding)
            super.drawText(in: insetsRect)
        }

        // Método para actualizar el padding
        func setPadding(_ padding: UIEdgeInsets) {
            self.padding = padding
            setNeedsDisplay()  // Redibuja el label para aplicar el nuevo padding
        }

    func updateContent(_ content: String) {
        self.text = content
    }

    func updateAlignment(_ alignment: NSTextAlignment) {
        self.textAlignment = alignment
    }
}

extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits)
        else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)  // Size 0 means to keep the size as is.
    }
}
