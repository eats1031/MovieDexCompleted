//
//  KeyboardManager.swift
//  MovieDex
//
//  Created by Luis Becerra on 4/12/24.
//

import UIKit

class KeyboardManager {
    private weak var view: UIView?
    var initialOriginY: CGFloat?
    var contentToShowMaxY: CGFloat?
    var extraHeight: CGFloat = 0

    init(view: UIView) {
        self.view = view
        addKeyboardObservers()
        addTapGestureToDismissKeyboard()
    }

    func setupFrames(
        initialOriginY: CGFloat, contentToShowMaxY: CGFloat,
        extraHeight: CGFloat = 0
    ) {
        self.initialOriginY = initialOriginY
        self.contentToShowMaxY = contentToShowMaxY
        self.extraHeight = extraHeight
    }

    deinit {
        removeKeyboardObservers()
    }

    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardDidShow(_:)),
            name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardDidShow(_ notification: Notification) {
        guard let view = self.view,
            let keyboardFrame = notification.userInfo?[
                UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        guard let contentToShowMaxY = self.contentToShowMaxY else { return }

        let keyboardWithAutoFillOrigin = keyboardFrame.origin.y - extraHeight

        if keyboardWithAutoFillOrigin < contentToShowMaxY {
            view.frame.origin.y =
                -(contentToShowMaxY - keyboardWithAutoFillOrigin)
        }

    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let view = self.view else { return }

        if let initialOriginY = self.initialOriginY {
            view.frame.origin.y = initialOriginY
        }
    }

    private func addTapGestureToDismissKeyboard() {
        guard let view = self.view else { return }
        let tapGesture = UITapGestureRecognizer(
            target: self, action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard(_ gesture: UITapGestureRecognizer) {
//        let touchLocation = gesture.location(in: self.view)
//            print("Touch location: \(touchLocation)")
        self.view?.endEditing(true)
    }
}
