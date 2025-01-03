//
//  EmailInputField.swift
//  MovieDex
//
//  Created by Luis Becerra on 28/11/24.
//

import SwiftUI
import UIKit

class BaseTextField: UITextField {
    private var areSubViewsLoaded = false
    private var label: String
    private var borderWidth: CGFloat = 1
    private var borderColor: UIColor = .border
    var onReturnPress: (() -> Void)?
    var validate: ((String) -> Bool)?
    private var _isPristine: Bool = true
    var isPristine: Bool {
        _isPristine
    }
    private var _isValid: Bool = true
    var isValid: Bool {
        _isValid
    }

    override var placeholder: String? {
        get {
            return label
        }
        set {
            print("⚠️ Warning: Placeholder was replaced by label property.")
            self.placeholder = ""
        }
    }
    
    // Exposing this property to modify text padding in subclasses.
    var textPadding = UIEdgeInsets(
        top: 0, left: 16, bottom: 0, right: 16)

    init(label: String = "", validate: ((String) -> Bool)? = nil) {
        self.label = label
        self.validate = validate
        super.init(frame: .zero)
        self.delegate = self
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var uiLabel: SmallTextLabel = {
        let uiLabel = SmallTextLabel()
        uiLabel.text = label
        uiLabel.setPadding(.init(top: 0, left: 4, bottom: 0, right: 4))
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
    }()

    private func setupView() {
        addSubview(uiLabel)
        uiLabel.layer.zPosition = 2
        self.layer.zPosition = 1

        self.addTarget(
            self, action: #selector(editingBegan), for: .editingDidBegin)
        self.addTarget(
            self, action: #selector(editingEnded), for: .editingDidEnd)
        self.addTarget(
            self, action: #selector(editingEnded), for: .editingChanged)

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50)
        ])

        moveLabelCenter()
    }

    @objc private func editingBegan() {
        self._isPristine = false
        if _isValid {
            moveLabelUp()
        }
    }
    
    @objc private func editingChange() {
        forceValidation()
    }

    @objc private func editingEnded() {
        forceValidation()
    }
    
    func forceValidation(){
        self._isValid = self.validate?((self.text ?? "")) ?? true
        if !_isValid {
            self.borderColor = .error
            self.uiLabel.textColor = .error
            moveLabelUp()
            self.uiLabel.textColor = .error
        } else {
            if let text = self.text, !text.isEmpty {
                moveLabelUp()
            } else {
                moveLabelCenter()
            }
        }
        setNeedsDisplay()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !self.areSubViewsLoaded && self.frame.height != 0 {
            moveLabelCenter()
            self.areSubViewsLoaded = true
        }
    }

    private func moveLabelUp() {
        let deltaY = self.uiLabel.frame.height / 2
        self.borderColor = .draculaPurple
        self.borderWidth = 2.0
        UIView.animate(withDuration: 0.16) {
            self.uiLabel.textColor = .draculaPurple
            self.uiLabel.resetSize()
            self.uiLabel.transform = CGAffineTransform(
                translationX: 12, y: -deltaY)
        } completion: { _ in
            self.setNeedsDisplay()
        }
    }

    private func moveLabelCenter() {
        self.layoutIfNeeded()
        self.uiLabel.updateSize(size: 16)
        let labelHeight = self.uiLabel.frame.height
        let height = self.frame.height
        let deltaY = (height - labelHeight) / 2
        self.borderColor = .border
        self.uiLabel.textColor = .border
        self.uiLabel.setNeedsDisplay()
        self.borderWidth = 1.0
        self.setNeedsDisplay()
        UIView.animate(withDuration: 0.16) {
            self.uiLabel.textColor = .lightGray
            self.uiLabel.transform = CGAffineTransform(
                translationX: 12, y: deltaY)
        }
    }
}

//MARK: - Return Event
extension BaseTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.onReturnPress?()
        return true
    }
}

// MARK: - Text Padding
extension BaseTextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?
    ) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.layer.borderColor = UIColor.border.cgColor
    }
}

// MARK: - Draw Custom Border
extension BaseTextField {
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let cornerRadius = 10.0
        let lineWidth: CGFloat = borderWidth
        let borderPath = UIBezierPath()
        borderPath.lineWidth = borderWidth
        let rect = bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)

        borderPath.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        if self.isEditing || !self.isValid || self.text?.count ?? 0 > 0 {
            borderPath.addLine(to: CGPoint(x: 12, y: rect.minY))
            borderPath.move(
                to: CGPoint(
                    x: rect.minX + 12 + self.uiLabel.frame.width + 4,
                    y: rect.minY))
        }
        borderPath.addLine(
            to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        borderPath.addArc(
            withCenter: CGPoint(
                x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius, startAngle: -.pi / 2, endAngle: 0,
            clockwise: true)

        borderPath.addLine(
            to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        borderPath.addArc(
            withCenter: CGPoint(
                x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius, startAngle: 0, endAngle: .pi / 2,
            clockwise: true)
        borderPath.addLine(
            to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        borderPath.addArc(
            withCenter: CGPoint(
                x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius, startAngle: .pi / 2, endAngle: .pi,
            clockwise: true)
        borderPath.addLine(
            to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        borderPath.addArc(
            withCenter: CGPoint(
                x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius, startAngle: -.pi, endAngle: -.pi / 2,
            clockwise: true)

        if self._isValid {
            borderColor.setStroke()
        } else {
            UIColor.error.setStroke()
        }
        borderPath.stroke()
    }
}

// MARK: - Preview SwiftUI
struct BaseTextFieldRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = BaseTextField(label: "Example")
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {

    }
}

#Preview {
    BaseTextFieldRepresentable()
}
